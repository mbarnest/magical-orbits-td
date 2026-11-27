class_name EnemySpawner extends Marker2D

@export var waves: Array[WaveData] = []
@export var initial_delay: float = 0.1

@onready var ground: TileMapLayer = $"../Map/Ground"
@onready var enemies: Node2D = $"../Enemies"
@onready var lbl_wave = $"../HUD/PanelContainer/HBoxContainer/LblWave"


func _ready() -> void:
	waves = WaveLoader.create_waves()
	await get_tree().create_timer(initial_delay, false).timeout
	for i: int in waves.size():
		GameManager.wave = i + 1
		GameManager.wave_total = waves.size()
		SignalManager.hud_update.emit()
		for group: SpawnGroup in waves[i].groups:
			for j: int in group.count:
				if not is_inside_tree():
					return
				spawn(group.enemy_scene)
				await get_tree().create_timer(group.interval, false).timeout
		if i < waves.size() - 1 and is_inside_tree():
			await get_tree().create_timer(waves[i].delay_after_wave, false).timeout
			
	while is_inside_tree() and get_tree().get_node_count_in_group("enemies") > 0:
		await get_tree().process_frame
		
	if is_inside_tree():
		GameManager.game_over()


func spawn(scene: PackedScene) -> void:
	var enemy: Enemy = scene.instantiate() as Enemy
	var row: int = randi_range(FlowField.AREA.position.y, FlowField.AREA.end.y - 1)
	var row_y: float = ground.to_global(ground.map_to_local(Vector2i(0, row))).y
	enemy.global_position = Vector2(global_position.x, row_y)
	enemies.add_child(enemy)
	
