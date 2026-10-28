class_name EnemyOrbit extends EnemyState

var current_angle: float = 0.0
var orbit_radius: float = 120.0
var angular_velocity: float = 3.0
var tower_ref: Node2D = null

func enter(msg := {}) -> void:
	if msg.has("tower"):
		tower_ref = msg["tower"]
	if msg.has("radius"):
		orbit_radius = msg["radius"]
	if msg.has("base_omega"):
		var mass = enemy.mass_value if enemy and enemy.mass_value > 0 else 1.0
		angular_velocity = msg["base_omega"] / mass

	if tower_ref and enemy:
		var offset: Vector2 = enemy.global_position - tower_ref.global_position
		current_angle = offset.angle()
		enemy.animated_sprite.play("walk")

func physics_update(delta: float) -> void:
	if not is_instance_valid(tower_ref) or not enemy:
		return
		
	current_angle += angular_velocity * delta
	var offset := Vector2(cos(current_angle), sin(current_angle)) * orbit_radius
	enemy.global_position = tower_ref.global_position + offset

func get_tangential_velocity() -> Vector2:
	var tangent_dir := Vector2(-sin(current_angle), cos(current_angle))
	var linear_speed := angular_velocity * orbit_radius
	return tangent_dir * linear_speed
