class_name TowerAttacking extends TowerState

@export_range(5.0, 30.0) var launch_angle_tolerance: float = 5.0
var target: Enemy

func enter(_msg := {}) -> void:
	tower.set_range_color(Color(1.0, 0.2, 0.2, 0.2))
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	target = get_most_advanced_enemy()

	#if not is_instance_valid(target):
		#return

	if target:
		for enemy in tower.orbiting_enemies:
			var linear_velocity: Vector2 = enemy.state_machine.current_state.get_tangential_velocity()
			var tangent_dir: Vector2 = linear_velocity.normalized()
			var dir_to_target: Vector2 = (target.global_position - enemy.global_position).normalized()
			var diff_angle: float = abs(tangent_dir.angle_to(dir_to_target))
			
			if diff_angle <= deg_to_rad(launch_angle_tolerance):
				enemy.state_machine.transition_to("Launched", {"velocity": linear_velocity})

func get_most_advanced_enemy() -> Enemy:
	var most_advanced_enemy: Enemy = null
	var max_x: float = -INF

	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.global_position.x > max_x:
			max_x = enemy.global_position.x
			most_advanced_enemy = enemy as Enemy

	return most_advanced_enemy
