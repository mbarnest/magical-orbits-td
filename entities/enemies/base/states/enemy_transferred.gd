class_name EnemyTransferred extends EnemyState

var target_tower: Tower

func enter(msg := {}) -> void:
	target_tower = msg.target_tower
	enemy.velocity = msg.velocity
	
	enemy.animated_sprite.self_modulate = Color.GREEN
	
	# enemy.collision_layer = 0
	# enemy.collision_mask = 0

func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	var vector_to_tower: Vector2 = target_tower.orbit_center.global_position - enemy.global_position
	var tower_distance: float = vector_to_tower.length()
	var direction: Vector2 = vector_to_tower.normalized()
	
	var tangent: Vector2 = direction.orthogonal()
	if tangent.dot(enemy.velocity) < 0:
		tangent = -tangent

	var gravity_acceleration: float = (GameManager.G * target_tower.mass) / pow(tower_distance, 2)
	var tangent_weight: float = clampf(remap(tower_distance, GameManager.TOWER_MIN_DISTANCE, GameManager.TOWER_MIN_DISTANCE + target_tower.orbit_radius, 1.0, 0.0), 0.0, 1.0)
	var force_dir: Vector2 = direction.lerp(tangent, tangent_weight).normalized()

	enemy.velocity += force_dir * gravity_acceleration * delta
	enemy.global_position += enemy.velocity * delta

	var passed_periapsis: bool = enemy.velocity.dot(direction) < 0
	
	if tower_distance <= target_tower.orbit_radius and passed_periapsis:
		enemy.state_machine.transition_to("Orbit", {"tower": target_tower})
