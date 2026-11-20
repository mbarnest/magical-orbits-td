class_name TowerDemolishing extends TowerState

func enter(_msg: Dictionary = {}) -> void:
	tower.state_label.text = "Demolishing"
	
	tower.load_bar.hide()
	tower.gem_sprite.hide()
	
	var tween_range = create_tween()
	tween_range.tween_property(tower.tower_range, "scale", Vector2.ZERO, 0.3)
	await tween_range.finished

	for enemy in tower.orbiting_enemies.duplicate():
		tower.unregister_orbiting_enemy(enemy)
		enemy.state_machine.transition_to("Die")

	var tween_tower = create_tween()
	tween_tower.tween_property(tower.base_sprite, "scale", Vector2.ZERO, 0.3)
	await tween_tower.finished

	tower.explosion.emitting = true
	await tower.explosion.finished
	
	tower.queue_free()

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
