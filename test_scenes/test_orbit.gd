extends Node2D

@export var orbit_radius: float = 120.0
@export var base_omega: float = 3.0

@onready var tower_marker: Sprite2D = $TowerMarker

func _physics_process(_delta: float) -> void:
	queue_redraw()
	
	for child in get_children():
		if child is Enemy:
			var enemy_node := child as Enemy
			var sm = enemy_node.state_machine
			if sm and sm.current_state:
				if sm.current_state.name == "Move":
					var distance := enemy_node.global_position.distance_to(tower_marker.global_position)
					if distance <= orbit_radius:
						sm.current_state.transition_requested.emit("Orbit", {
							"tower": tower_marker,
							"radius": orbit_radius,
							"base_omega": base_omega
						})


func _draw() -> void:
	if not is_instance_valid(tower_marker):
		return
		
	draw_arc(tower_marker.global_position, orbit_radius, 0, TAU, 32, Color.GREEN, 2.0)
	
	for child in get_children():
		if child is Enemy:
			var enemy_node := child as Enemy
			var sm = enemy_node.state_machine
			if sm and sm.current_state and sm.current_state.name == "Orbit":
				var orbit_state = sm.current_state
				var v_tangent: Vector2 = orbit_state.get_tangential_velocity()
				draw_line(
					enemy_node.global_position, 
					enemy_node.global_position + v_tangent.normalized() * 50.0, 
					Color.RED, 
					3.0
				)
