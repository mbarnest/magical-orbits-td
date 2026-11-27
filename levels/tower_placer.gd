class_name TowerPlacer extends Control


const SFX_COINS: Resource = preload("res://assets/sfx/Pickups_Items_TreasureChest_002.mp3")

const COLOR_VALID: Color = Color(0.2, 1, 0.2, 0.2)
const COLOR_INVALID: Color = Color(1, 0.2, 0.2, 0.2)

@export var tower_scene: PackedScene

@onready var ground: TileMapLayer = $"../Map/Ground"
@onready var towers: Node2D = $"../Towers"
@onready var flow_field: FlowField = $"../FlowField"
@onready var range_preview: Sprite2D = $RangePreview
@onready var tile_size := Vector2(ground.tile_set.tile_size)

#var occupied: Array[Vector2i] = []

func _ready() -> void:
	hide()
	range_preview.hide()
	size = get_viewport_rect().size
	SignalManager.build_mode_active.connect(set_visible)

	var radius: float = Tower.LEVELS[1].radius
	range_preview.scale = Vector2.ONE * (radius / (range_preview.texture.get_width() * 0.5))

	for x in range(1, FlowField.AREA.end.x - 1):
		for y in range(FlowField.AREA.position.y, FlowField.AREA.end.y):
			add_button(Vector2i(x, y))

func add_button(cell: Vector2i) -> void:
	var btn := Button.new()
	btn.size = tile_size
	btn.modulate.a = 0.0
	btn.pressed.connect(place_tower.bind(cell))
	btn.mouse_entered.connect(on_cell_hovered.bind(cell))
	btn.mouse_exited.connect(range_preview.hide)
	add_child(btn)
	btn.global_position = ground.map_to_local(cell) - tile_size * 0.5

func can_build(cell: Vector2i) -> bool:
	#return cell not in occupied and flow_field.can_place(cell)
	return flow_field.can_place(cell)

func on_cell_hovered(cell: Vector2i) -> void:
	range_preview.modulate = COLOR_VALID if can_build(cell) else COLOR_INVALID
	range_preview.global_position = ground.map_to_local(cell + Vector2i.UP) + Vector2(0, 48)
	range_preview.show()

func place_tower(cell: Vector2i) -> void:
	if not tower_scene or not can_build(cell):
		return

	var tower := tower_scene.instantiate() as Tower
	tower.global_position = ground.map_to_local(cell + Vector2i.UP)
	towers.add_child(tower)
	GameManager.mana -= GameManager.TOWER_PRICE
	SignalManager.hud_update.emit()
	AudioManager.play_sfx(SFX_COINS)

	#occupied.append_array([cell, cell + Vector2i.UP])
	range_preview.hide()
	SignalManager.towers_changed.emit()
	SignalManager.build_mode_active.emit(false)
