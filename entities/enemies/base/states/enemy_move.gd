class_name EnemyMove extends EnemyState

func enter(_msg := {}) -> void:
	enemy.add_to_group("enemies")
	enemy.animated_sprite.play("walk")
	
	enemy.set_collision_layer_value(5, true)

func physics_update(delta: float) -> void:
	enemy.velocity = Vector2.RIGHT * enemy.speed
	enemy.global_position += enemy.velocity * delta

func exit():
	enemy.remove_from_group("enemies")
	enemy.set_collision_layer_value(5, false)
