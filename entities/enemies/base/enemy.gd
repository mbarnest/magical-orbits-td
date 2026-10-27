class_name Enemy extends CharacterBody2D

@export_group("Stats")
@export var speed: float = 100.0
@export var mass_value: float = 1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
