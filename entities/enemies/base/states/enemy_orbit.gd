class_name EnemyOrbit extends EnemyState

@export var current_angle: float = 0.0
@export var orbit_radius: float = 120.0
@export var angular_velocity: float = 3.0

var tower_ref: Node2D = null

func enter(msg := {}) -> void:
	tower_ref = msg["tower"]
	orbit_radius = msg["radius"]
	angular_velocity = msg["base_omega"] / enemy.mass

	var offset: Vector2 = enemy.global_position - tower_ref.global_position
	current_angle = offset.angle()
	enemy.animated_sprite.play("walk")

func physics_update(delta: float) -> void:
	current_angle += angular_velocity * delta
	var offset := Vector2(cos(current_angle), sin(current_angle)) * orbit_radius
	enemy.global_position = tower_ref.global_position + offset

func get_tangential_velocity() -> Vector2:
	var tangent_dir := Vector2(-sin(current_angle), cos(current_angle))
	var linear_speed := angular_velocity * orbit_radius
	return tangent_dir * linear_speed
