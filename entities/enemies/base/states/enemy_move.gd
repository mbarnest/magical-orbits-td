class_name EnemyMove extends EnemyState

func enter(_msg: Dictionary = {}) -> void:
	enemy.add_to_group("enemies")
	enemy.state_label.text = enemy.state_machine.current_state.name

	enemy.animated_sprite.play("walk")
	
	enemy.set_collision_layer_value(5, true)
	
	SignalManager.hud_update.emit()


func physics_update(delta: float) -> void:
	var direction: Vector2 = enemy.flow_field.get_direction(enemy.global_position) if enemy.flow_field else Vector2.RIGHT
	enemy.velocity = direction * enemy.speed
	enemy.global_position += enemy.velocity * delta

func exit():
	enemy.remove_from_group("enemies")
	enemy.set_collision_layer_value(5, false)
