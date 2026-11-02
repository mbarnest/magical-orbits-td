class_name TowerTransferring extends TowerState

var target_tower: Tower
var previous_state: String

func enter(msg := {}) -> void:
	tower.set_range_color(Color(0.2, 1.0, 0.4, 0.2))
	previous_state = msg.previous_state
	target_tower = null
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	if target_tower:
		for enemy in tower.orbiting_enemies.duplicate():
			if is_instance_valid(enemy):
				enemy.state_machine.transition_to("Transferred", {"tower": target_tower})

func set_target(target: Tower) -> void:
	if target == tower:
		tower.state_machine.transition_to(previous_state)
	else:
		target_tower = target

func transfer_to(target: Tower) -> void:
	for enemy in tower.orbiting_enemies:
		enemy.state_machine.transition_to("Orbit", {"tower": target})

func _unhandled_input(event: InputEvent) -> void:
	#tower.state_machine.transition_to(previous_state)
	pass
