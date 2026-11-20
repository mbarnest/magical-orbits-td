class_name FlowField extends Node2D

const AREA: Rect2i = Rect2i(0, 1, 30, 14)
const DIRS: Array = [Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN, Vector2i(1, -1), Vector2i(1, 1)]

@onready var ground: TileMapLayer = $"../Map/Ground"
@onready var towers: Node2D = $"../Towers"
@onready var tile_size: float = float(ground.tile_set.tile_size.x)

@export var i_max: float = 3.5
@export var attenuation_k: float = 0.5

var influence: Array = []
var vectors: Array = []

func _ready() -> void:
	SignalManager.towers_changed.connect(recalculate)
	recalculate()

func recalculate() -> void:
	calculate_influence()
	calculate_vectors()
	queue_redraw()

func calculate_influence() -> void:
	influence = grid(0.0)
	influence[29][1]=INF
	influence[29][14]=INF
	for tower: Tower in towers.get_children():
		block_tower_cells(ground.local_to_map(tower.global_position) + Vector2i.DOWN)
		set_tower_weight(tower)

func calculate_vectors() -> void:
	var dist: Array = grid(INF)
	vectors = grid(Vector2i.ZERO)
	var open: Array[Vector2i] = []
	var goal_x: int = AREA.end.x - 1

	for y: int in range(AREA.position.y, AREA.end.y):
		if not is_inf(influence[goal_x][y]):
			dist[goal_x][y] = 0.0
			vectors[goal_x][y] = Vector2i.RIGHT
			open.append(Vector2i(goal_x, y))

	while not open.is_empty():
		open.sort_custom(func(a: Vector2i, b: Vector2i) -> bool: return dist[a.x][a.y] < dist[b.x][b.y])
		var curr: Vector2i = open.pop_front()
		for dir: Vector2i in DIRS:
			var prev: Vector2i = curr - dir
			if not can_move(prev, curr, dir):
				continue
			var cost: float = dist[curr.x][curr.y] + Vector2(dir).length() + influence[curr.x][curr.y]
			if cost < dist[prev.x][prev.y]:
				dist[prev.x][prev.y] = cost
				vectors[prev.x][prev.y] = dir
				if not prev in open:
					open.append(prev)

func block_tower_cells(base_cell: Vector2i) -> void:
	for cell: Vector2i in [base_cell, base_cell + Vector2i.UP]:
		if AREA.has_point(cell):
			influence[cell.x][cell.y] = INF

func set_tower_weight(tower: Tower) -> void:
	var center: Vector2 = tower.orbit_center.global_position
	var radius: float = tower.get_range_radius()
	for x: int in range(AREA.position.x, AREA.end.x):
		for y: int in range(AREA.position.y, AREA.end.y):
			var dist_px: float = ground.map_to_local(Vector2i(x, y)).distance_to(center)
			if dist_px <= radius:
				influence[x][y] += i_max / (1.0 + attenuation_k * (dist_px / tile_size))

func can_place(cell: Vector2i) -> bool:
	var top: Vector2i = cell + Vector2i.UP
	if cell.x == 0 or is_blocked(cell) or (AREA.has_point(top) and is_blocked(top)):
		return false
	block_tower_cells(cell)
	calculate_vectors()
	var valid: bool = has_valid_paths()
	recalculate()
	return valid

func has_valid_paths() -> bool:
	for y: int in range(AREA.position.y, AREA.end.y):
		if vectors[0][y] == Vector2i.ZERO:
			return false
	return true

func is_blocked(c: Vector2i) -> bool:
	return not AREA.has_point(c) or is_inf(influence[c.x][c.y])

func can_move(from: Vector2i, to: Vector2i, dir: Vector2i) -> bool:
	if is_blocked(from) or is_blocked(to):
		return false
	return dir.x * dir.y == 0 or (not is_blocked(from + Vector2i(dir.x, 0)) and not is_blocked(from + Vector2i(0, dir.y)))

func grid(val: Variant) -> Array:
	var g: Array = []
	for x: int in AREA.end.x:
		var col: Array = []
		col.resize(AREA.end.y)
		col.fill(val)
		g.append(col)
	return g

func get_direction(pos: Vector2) -> Vector2:
	var raw_cell: Vector2i = ground.local_to_map(pos)
	if raw_cell.x >= AREA.end.x:
		return Vector2.RIGHT
	var c: Vector2i = raw_cell.clamp(AREA.position, AREA.end - Vector2i.ONE)
	if vectors[c.x][c.y] == Vector2i.ZERO:
		return Vector2.RIGHT
	var target: Vector2 = ground.map_to_local(c + vectors[c.x][c.y])
	return (target - pos).normalized()

func _draw() -> void:
	if  GameManager.show_debug:
		for x: int in range(AREA.position.x, AREA.end.x):
			for y: int in range(AREA.position.y, AREA.end.y):
				var dir: Vector2i = vectors[x][y]
				if dir != Vector2i.ZERO:
					var v: Vector2 = Vector2(dir).normalized()
					var p: Vector2 = ground.map_to_local(Vector2i(x, y))
					draw_line(p - v * 12.0, p + v * 16.0, Color.CYAN, 2.0)
					draw_circle(p + v * 16.0, 3.0, Color.WHITE)
