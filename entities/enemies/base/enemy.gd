class_name Enemy extends CharacterBody2D

@export var speed: float = 100.0
@export var mass: float = 1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel

func _process(_delta):
	state_label.text = state_machine.current_state.name
