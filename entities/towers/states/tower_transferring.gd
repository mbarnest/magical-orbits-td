class_name TowerTransferring extends TowerState

@export_range(5.0, 30.0) var launch_angle_tolerance: float = 5.0

var target_tower: Tower
var previous_state: String

func enter(msg := {}) -> void:
	tower.set_range_color(Color(0.2, 1.0, 0.4, 0.2))
	previous_state = msg.previous_state
	target_tower = null
	
	SignalManager.target_selected.connect(_on_target_selected)
	SignalManager.transfer_cancelled.connect(_on_transfer_cancelled)
	SignalManager.transfer_mode_changed.emit(true, tower)
	
func exit() -> void:
	disconnect_signals()
	SignalManager.transfer_mode_changed.emit(false, tower)


func physics_update(_delta: float) -> void:
	if target_tower:
		for enemy in tower.orbiting_enemies:
			if enemy.state_machine.current_state is EnemyOrbit:
				var linear_velocity: Vector2 = enemy.state_machine.current_state.get_tangential_velocity()
				var tangent_dir: Vector2 = linear_velocity.normalized()
				var dir_to_target: Vector2 = (target_tower.orbit_center.global_position - enemy.global_position).normalized()
				var diff_angle: float = abs(tangent_dir.angle_to(dir_to_target))
				
				if diff_angle <= deg_to_rad(launch_angle_tolerance):
					enemy.state_machine.transition_to("Transferred", {
						"target_tower": target_tower,
						"velocity": linear_velocity
					})

func _on_target_selected(target: Tower) -> void:
	target_tower = target
	SignalManager.transfer_mode_changed.emit(false, tower)
	disconnect_signals()

func _on_transfer_cancelled() -> void:
	tower.state_machine.transition_to(previous_state)

func disconnect_signals() -> void:
	SignalManager.transfer_cancelled.disconnect(_on_transfer_cancelled)
	SignalManager.target_selected.disconnect(_on_target_selected)
