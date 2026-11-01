class_name EnemyMove extends EnemyState

func enter(_msg := {}) -> void:
	enemy.add_to_group("enemies")
	enemy.animated_sprite.play("walk")

func physics_update(_delta: float) -> void:
	enemy.velocity = Vector2.RIGHT * enemy.speed
	enemy.move_and_slide()

func exit():
	enemy.remove_from_group("enemies")
