class_name TowerPlacer extends Control

@export var tower_scene: PackedScene

@onready var ground = $"../Map/Ground"
@onready var towers = $"../Towers"
@onready var flow_field = $"../FlowField"

func _ready() -> void:
	var tile_size := Vector2(ground.tile_set.tile_size)
	for x: int in range(1, FlowField.AREA.end.x):
		for y: int in range(FlowField.AREA.position.y, FlowField.AREA.end.y):
			var cell := Vector2i(x, y)
			var btn := Button.new()
			btn.size = tile_size
			btn.global_position = ground.to_global(ground.map_to_local(cell)) - tile_size * 0.5
			btn.modulate.a = 0.2
			btn.pressed.connect(_place_tower.bind(cell, btn))
			add_child(btn)

func _place_tower(cell: Vector2i, btn: Button) -> void:
	if not tower_scene or not flow_field.can_place(cell):
		return
	var tower := tower_scene.instantiate() as Tower
	tower.global_position = ground.to_global(ground.map_to_local(cell))
	towers.add_child(tower)
	btn.queue_free()
	SignalManager.towers_changed.emit()
