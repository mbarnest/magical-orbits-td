class_name TowerDemolishing extends TowerState

func enter(_msg: Dictionary = {}) -> void:
	tower.state_label.text = "Demolishing"
	
	for enemy in tower.orbiting_enemies.duplicate():
		tower.unregister_orbiting_enemy(enemy)
		enemy.state_machine.transition_to("Die")
	#queue_free()

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
