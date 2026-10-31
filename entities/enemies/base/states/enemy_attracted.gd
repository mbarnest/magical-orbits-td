class_name EnemyAttracted extends EnemyState

var tower_mass: float
var orbit_center: Vector2
var orbit_radius: float

const MIN_DIST: float = 100.0

func enter(msg := {}) -> void:
	tower_mass = msg["tower_mass"]
	orbit_center = msg["orbit_center"]
	orbit_radius = msg["orbit_radius"]

func physics_update(delta: float) -> void:
	var vector_to_tower: Vector2 = orbit_center - enemy.global_position
	var tower_distance: float = vector_to_tower.length()
	var direction: Vector2 = vector_to_tower.normalized()
	
	# Tangent force to prevent enemies from impacting the tower
	var tangent: Vector2 = direction.orthogonal()
	if tangent.dot(enemy.velocity) < 0:
		tangent = -tangent
	
	# Gravitational acceleration from Newton's law of universal gravitation
	var gravity_acceleration: float = (GameConstants.G * tower_mass) / pow(tower_distance, 2)
	
	# This factor determines the proportion between the gravitational force and the tangential force
	var tangent_weight: float = clampf(remap(tower_distance, MIN_DIST, MIN_DIST + orbit_radius, 1.0, 0.0), 0.0, 1.0)
	var force_dir: Vector2 = direction.lerp(tangent, tangent_weight).normalized()
	
	enemy.velocity += force_dir * gravity_acceleration * delta
	
	enemy.move_and_slide()
	
	# Passed the closest point to the tower the state must change to Orbit
	var passed_periapsis: bool = enemy.velocity.dot(direction) < 0
	
	if tower_distance <= orbit_radius and passed_periapsis:
		var msg = {
			"tower_mass": tower_mass,
			"orbit_center": orbit_center,
			"orbit_radius": orbit_radius,
		}
		print(msg)
		enemy.state_machine.transition_to("Orbit", msg)
