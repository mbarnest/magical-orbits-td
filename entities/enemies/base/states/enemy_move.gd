class_name EnemyMove extends EnemyState

func enter(_msg := {}) -> void:
	enemy.animated_sprite.play("walk")

func physics_update(_delta: float) -> void:
	enemy.velocity = Vector2.RIGHT * enemy.speed
	enemy.move_and_slide()

func exit():
	pass
