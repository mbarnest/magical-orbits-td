class_name TowerTransferring extends TowerState

@export_range(0.1, 30.0) var launch_window_angle: float = 30.0

var target_tower: Tower
var previous_state: String


func enter(msg: Dictionary = {}) -> void:
	tower.state_label.text = "Transferring"

	tower.set_range_color(Color(0.1, 1.0, 0.2, 0.22))
	previous_state = msg.previous_state
	target_tower = null
	
	SignalManager.transfer_mode_changed.emit(true, tower)
	SignalManager.target_selected.connect(_on_target_selected)
	SignalManager.transfer_cancelled.connect(_on_transfer_cancelled)
	SignalManager.tower_demolished.connect(_on_tower_demolished)
	
func exit() -> void:
	disconnect_selection_signals()
	SignalManager.tower_demolished.disconnect(_on_tower_demolished)
	
	SignalManager.transfer_mode_changed.emit(false, tower)


func physics_update(_delta: float) -> void:
	if not target_tower:
		return

	if tower.global_position.distance_to(target_tower.global_position) < tower.get_range_radius():
		tower.state_machine.transition_to("Orbiting")
		return

	for enemy in tower.orbiting_enemies:
		if target_tower.max_attract_mass < target_tower.load_bar.value + enemy.mass:
			continue

		var vel: Vector2 = enemy.state_machine.current_state.get_tangential_velocity()
		var to_target: Vector2 = target_tower.orbit_center.global_position - enemy.global_position

		if abs(vel.angle_to(to_target)) <= deg_to_rad(launch_window_angle):
			enemy.state_machine.transition_to("Transferred", {
				"target_tower": target_tower,
				"velocity": to_target.normalized() * vel.length()
			})


func disconnect_selection_signals() -> void:
	if SignalManager.target_selected.is_connected(_on_target_selected):
		SignalManager.target_selected.disconnect(_on_target_selected)
		
	if SignalManager.transfer_cancelled.is_connected(_on_transfer_cancelled):
		SignalManager.transfer_cancelled.disconnect(_on_transfer_cancelled)


func _on_target_selected(target: Tower) -> void:
	target_tower = target
	SignalManager.transfer_mode_changed.emit(false, tower)
	disconnect_selection_signals()


func _on_transfer_cancelled() -> void:
	tower.state_machine.transition_to(previous_state)


func _on_tower_demolished(demolished_tower) -> void:
	if target_tower == demolished_tower:
		tower.state_machine.transition_to("Orbiting")
