class_name EnemyMove extends EnemyState

func enter(_msg := {}) -> void:
	if enemy.animated_sprite:
		enemy.animated_sprite.play("walk")

func physics_update(_delta: float) -> void:
	enemy.velocity = Vector2.RIGHT * enemy.speed
	enemy.move_and_slide()
