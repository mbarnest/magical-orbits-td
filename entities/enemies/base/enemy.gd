class_name Enemy extends CharacterBody2D

@export_group("Stats")
@export var speed: float = 100.0
@export var mass_value: float = 1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel

func _ready() -> void:
	if state_machine:
		state_machine.state_changed.connect(_on_state_changed)
		if state_machine.current_state and state_label:
			state_label.text = state_machine.current_state.name

func _on_state_changed(new_state_name: String) -> void:
	if state_label:
		state_label.text = new_state_name
