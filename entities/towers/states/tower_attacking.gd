class_name TowerAttacking extends TowerState

@export_range(0.1, 30.0) var launch_window_angle: float = 5.0
var target: Enemy

func enter(_msg := {}) -> void:
	tower.state_label.text = "Attacking"
	tower.set_range_color(Color(1.0, 0.0, 0.149, 0.353))
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	target = get_most_advanced_enemy()
	if not target:
		return

	for enemy in tower.orbiting_enemies:
		var vel: Vector2 = enemy.state_machine.current_state.get_tangential_velocity()
		var speed: float = vel.length()

		var time_to_target: float = enemy.global_position.distance_to(target.global_position) / speed
		var target_future_position: Vector2 = (target.global_position + target.velocity * time_to_target) - enemy.global_position

		if abs(vel.angle_to(target_future_position)) <= deg_to_rad(launch_window_angle):
			enemy.state_machine.transition_to("Launched", {"velocity": target_future_position.normalized() * speed})


func get_most_advanced_enemy() -> Enemy:
	var most_advanced_enemy: Enemy = null
	var max_x: float = -INF

	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.global_position.x > max_x:
			max_x = enemy.global_position.x
			most_advanced_enemy = enemy as Enemy

	return most_advanced_enemy
