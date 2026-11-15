class_name TowerOrbiting extends TowerState

func enter(_msg := {}) -> void:
	tower.state_label.text = "Orbiting"
	tower.set_range_color(Color(0.18, 0.0, 1.0, 0.38))

	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
