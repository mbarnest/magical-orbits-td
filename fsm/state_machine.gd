class_name StateMachine extends Node

# Initial state set from the Inspector
@export var initial_state: State

var current_state: State

func _ready() -> void:
	await owner.ready
	
	# Connect transition signals from all child State nodes
	for child in get_children():
		child.transition_requested.connect(_on_transition_requested)

	# Enter initial state
	current_state = initial_state
	current_state.enter()

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

# Handles switching from current_state to target_state
func _on_transition_requested(target_state_name: String, msg := {}) -> void:
	current_state.exit()
	
	current_state = get_node(target_state_name) as State
	current_state.enter(msg)
