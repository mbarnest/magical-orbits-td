class_name EnemySpawner extends Marker2D

const MUSIC_WAVE = preload("res://assets/music/Three Red Hearts - Connected.ogg")
const SFX_WAVE = preload("res://assets/sfx/Retro_8bit_8bitCoin_010.mp3")

@export var waves: Array[WaveData] = []
@export var initial_delay: float = 0.1

@onready var ground: TileMapLayer = $"../Map/Ground"
@onready var enemies: Node2D = $"../Enemies"
@onready var lbl_wave = $"../HUD/PanelContainer/HBoxContainer/LblWave"
@onready var timer = $Timer


func _ready() -> void:
	if waves.is_empty():
		waves = WaveLoader.create_waves()
	
	start_waves()


func start_waves() -> void:
	await wait(initial_delay)
	
	AudioManager.play_music(MUSIC_WAVE)
	
	for i: int in waves.size():
		AudioManager.play_sfx(SFX_WAVE)
		GameManager.wave = i + 1
		GameManager.wave_total = waves.size()
		SignalManager.hud_update.emit()
		
		for group: SpawnGroup in waves[i].groups:
			for j: int in group.count:
				spawn(group.enemy_scene, waves[i].hp_multiplier)
				await wait(group.interval)
				
		if i < waves.size() - 1:
			await wait(waves[i].delay_after_wave)
			
	while get_tree().get_node_count_in_group("enemies") > 0:
		await wait(0.2)
		
	GameManager.game_over()


func spawn(scene: PackedScene, hp_mult: float) -> void:
	var enemy: Enemy = scene.instantiate() as Enemy
	enemy.health *= hp_mult
	var row: int = randi_range(FlowField.AREA.position.y, FlowField.AREA.end.y - 1)
	var row_y: float = ground.to_global(ground.map_to_local(Vector2i(0, row))).y
	enemy.global_position = Vector2(global_position.x, row_y)
	enemies.add_child(enemy)
	

func wait(seconds: float) -> void:
	timer.start(seconds)
	await timer.timeout
