class_name EnemyOrbit extends EnemyState

var current_angle: float
var current_radius: float
var orbit_center: Vector2
var orbit_radius: float
var angular_velocity: float
var target_angular_velocity: float

func enter(msg := {}) -> void:
	var tower_mass = msg["tower_mass"]
	orbit_center = msg["orbit_center"]
	orbit_radius = msg["orbit_radius"]

	var vector_to_enemy = enemy.global_position - orbit_center
	current_angle = vector_to_enemy.angle()
	current_radius = vector_to_enemy.length()
	
	# Relative position and velocity determines the spin direction
	var spin_direction = -1.0 if vector_to_enemy.cross(enemy.velocity) < 0 else 1.0
	
	target_angular_velocity = sqrt((GameConstants.G * tower_mass) / pow(orbit_radius, 3)) * spin_direction
	angular_velocity = (enemy.velocity.length() / max(current_radius, 1.0)) * spin_direction

func physics_update(delta: float) -> void:
	# Soft transition between the actual radius and velocity to target radius and velocity
	current_radius = lerp(current_radius, orbit_radius, delta)
	angular_velocity = lerp(angular_velocity, target_angular_velocity, delta)
	
	current_angle += angular_velocity * delta
	enemy.global_position = orbit_center + Vector2(cos(current_angle), sin(current_angle)) * current_radius
