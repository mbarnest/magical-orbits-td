class_name EnemySpawner extends Marker2D

signal wave_started(current: int, total: int)
signal all_waves_completed

@export var waves: Array[WaveData] = []
@export var initial_delay: float = 3.0

@onready var ground: TileMapLayer = $"../Map/Ground"
@onready var enemies: Node2D = $"../Enemies"

func _ready() -> void:
	await get_tree().create_timer(initial_delay).timeout
	for i: int in waves.size():
		wave_started.emit(i + 1, waves.size())
		for group: SpawnGroup in waves[i].groups:
			for _j: int in group.count:
				if not is_inside_tree():
					return
				_spawn(group.enemy_scene)
				await get_tree().create_timer(group.interval).timeout
		if i < waves.size() - 1 and is_inside_tree():
			await get_tree().create_timer(waves[i].delay_after_wave).timeout
	if is_inside_tree():
		all_waves_completed.emit()

func _spawn(scene: PackedScene) -> void:
	var enemy: Enemy = scene.instantiate() as Enemy
	var row: int = randi_range(FlowField.AREA.position.y, FlowField.AREA.end.y - 1)
	var row_y: float = ground.to_global(ground.map_to_local(Vector2i(0, row))).y
	enemy.global_position = Vector2(global_position.x, row_y)
	enemies.add_child(enemy)
