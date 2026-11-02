class_name EnemyDie extends EnemyState

func enter(_msg := {}) -> void:
	enemy.set_deferred("collision_layer", 0)
	enemy.set_deferred("collision_mask", 0)
	
	enemy.velocity = Vector2.ZERO
	enemy.animated_sprite.play("die")
	await enemy.animated_sprite.animation_finished
	enemy.queue_free()
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
