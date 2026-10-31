class_name StateMachine extends Node

# Initial state set from the Inspector
@export var initial_state: State

var current_state: State

func _ready() -> void:
	await owner.ready

	# Enter the initial state assigned in the Inspector
	current_state = initial_state
	current_state.enter()

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

# Switch from current_state to target_state
func transition_to(target_state_name: String, msg := {}) -> void:
	current_state.exit()
	
	current_state = get_node(target_state_name) as State
	current_state.enter(msg)
