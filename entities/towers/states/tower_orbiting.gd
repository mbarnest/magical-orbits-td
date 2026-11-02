class_name TowerOrbiting extends TowerState

func enter(_msg := {}) -> void:
	tower.set_range_color(Color(0.2, 0.6, 1.0, 0.2))
	
func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
