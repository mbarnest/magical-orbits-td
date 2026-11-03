class_name EnemyAttracted extends EnemyState

var tower: Tower

func enter(msg := {}) -> void:
	tower = msg.tower

func exit() -> void:
	pass

func physics_update(delta: float) -> void:
	var vector_to_tower: Vector2 = tower.orbit_center.global_position - enemy.global_position
	var tower_distance: float = vector_to_tower.length()
	var direction: Vector2 = vector_to_tower.normalized()
	
	# Tangent force to prevent enemies from impacting the tower
	var tangent: Vector2 = direction.orthogonal()
	if tangent.dot(enemy.velocity) < 0:
		tangent = -tangent
	
	# Gravitational acceleration from Newton's law of universal gravitation
	var gravity_acceleration: float = (GameManager.G * tower.mass) / pow(tower_distance, 2)
	
	# This factor determines the proportion between the gravitational force and the tangential force
	var tangent_weight: float = clampf(remap(tower_distance, GameManager.TOWER_MIN_DISTANCE, GameManager.TOWER_MIN_DISTANCE + tower.orbit_radius, 1.0, 0.0), 0.0, 1.0)
	var force_dir: Vector2 = direction.lerp(tangent, tangent_weight).normalized()
	
	enemy.velocity += force_dir * gravity_acceleration * delta
	enemy.global_position += enemy.velocity * delta
	
	# Passed the closest point to the tower the state must change to Orbit
	var passed_periapsis: bool = enemy.velocity.dot(direction) < 0
	
	if tower_distance <= tower.orbit_radius and passed_periapsis:
		var msg = { "tower": tower }
		enemy.state_machine.transition_to("Orbit", msg)
