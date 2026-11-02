class_name EnemyTransferred extends EnemyState

func enter(_msg := {}) -> void:
	enemy.animated_sprite.self_modulate = Color.GREEN
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
