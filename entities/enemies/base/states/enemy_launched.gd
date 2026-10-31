class_name EnemyLaunched extends EnemyState

var launch_velocity: Vector2
var enemy_mass: float

func enter(msg := {}) -> void:
	launch_velocity = msg["velocity"]

func physics_update(_delta: float) -> void:
	enemy.global_position += launch_velocity * _delta
	var damage = 0.5 * enemy_mass * pow(launch_velocity.length(), 2)
