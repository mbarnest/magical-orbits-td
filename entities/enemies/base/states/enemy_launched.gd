class_name EnemyLaunched extends EnemyState

const SFX_LAUNCH: Resource = preload("res://assets/sfx/Retro_8bit_8bitShoot_004.mp3")
const SFX_HIT: Resource = preload("res://assets/sfx/Retro_8bit_8bitHit_010.mp3")

var launch_velocity: Vector2

func enter(msg: Dictionary = {}) -> void:
	enemy.state_label.text = enemy.state_machine.current_state.name
	
	enemy.area_entered.connect(_on_area_entered)
	SignalManager.hud_update.emit()
	
	enemy.collision_layer = 0
	enemy.collision_mask = 0
	enemy.set_collision_layer_value(3, true)
	enemy.set_collision_mask_value(5, true)
	
	enemy.animated_sprite.self_modulate = Color.FIREBRICK
	
	launch_velocity = msg.velocity
	
	AudioManager.play_sfx(SFX_LAUNCH)

func exit() -> void:
	enemy.area_entered.disconnect(_on_area_entered)
	
	enemy.set_collision_layer_value(3, false)
	enemy.set_collision_mask_value(5, false)

func physics_update(_delta: float) -> void:
	enemy.global_position += launch_velocity * _delta

func _on_area_entered(enemy_hitted: Enemy) -> void:
	var damage = 0.5 * enemy.mass * pow(launch_velocity.length(), 2)
	enemy_hitted.take_damage(damage)

	AudioManager.play_sfx(SFX_HIT)
	enemy.queue_free()
