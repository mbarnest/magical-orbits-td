class_name Tower extends Node2D

@export_range(1,3) var level: int = 1
@export var mass: float
@export var orbit_radius: float

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var orbit_center = $Range/OrbitCenter

func _process(_delta):
	state_label.text = state_machine.current_state.name

func _on_range_body_entered(body):
	var msg = {
		"tower" = self,
		"tower_mass" = mass,
		"orbit_center" = orbit_center.global_position,
		"orbit_radius" = orbit_radius
	}
	body.state_machine.transition_to("Attracted", msg)

func _on_range_body_exited(body):
	body.state_machine.transition_to("Move")
