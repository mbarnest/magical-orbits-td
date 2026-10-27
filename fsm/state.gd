class_name State extends Node

# Signal emitted when the state wants to transition to a new state
signal transition_requested(target_state_name: String, msg: Dictionary)

# Called when entering the state
func enter(_msg := {}) -> void:
	pass

# Called when exiting the state
func exit() -> void:
	pass

# Called during the physics processing loop
func physics_update(_delta: float) -> void:
	pass
