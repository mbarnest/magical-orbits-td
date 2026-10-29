class_name Tower extends Node2D

@export_range(1,3) var level: int = 1

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel

func _process(delta):
	state_label.text = state_machine.current_state.name

 
