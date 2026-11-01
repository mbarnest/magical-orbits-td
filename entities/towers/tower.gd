class_name Tower extends Node2D

@export_range(1,3) var level: int = 1
@export var mass: float
@export var orbit_radius: float

var orbiting_enemies: Array[Enemy] = []

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var orbit_center = $Range/OrbitCenter

func _process(_delta):
	state_label.text = state_machine.current_state.name

func register_orbiting_enemy(enemy: Enemy) -> void:
	orbiting_enemies.append(enemy)

func unregister_orbiting_enemy(enemy: Enemy) -> void:
	orbiting_enemies.erase(enemy)

func _on_range_body_entered(body: Enemy):
	if body.state_machine.current_state.name == "Move":
		body.state_machine.transition_to("Attracted", {"tower": self})

func _on_range_body_exited(body: Enemy):
	if body.state_machine.current_state.name == "Attracted":
		body.state_machine.transition_to("Move")
