class_name TowerDemolishing extends TowerState

const SFX_DEMOLISHING = preload("res://assets/sfx/Retro_8bit_8bitShoot_003.mp3")

func enter(_msg: Dictionary = {}) -> void:
	GameManager.mana += GameManager.TOWER_PRICE
	tower.state_label.text = "Demolishing"
	
	tower.btn_tower.disabled = true
	
	tower.state_menu.hide()
	tower.load_bar.hide()
	tower.gem_sprite.hide()
	
	var tween_range = create_tween()
	tween_range.tween_property(tower.tower_range, "scale", Vector2.ZERO, 0.3)
	await tween_range.finished

	for enemy in tower.orbiting_enemies.duplicate():
		tower.unregister_orbiting_enemy(enemy)
		enemy.state_machine.transition_to("Die")

	SignalManager.tower_demolished.emit(tower)
	
	var tween_tower = create_tween()
	tween_tower.tween_property(tower.base_sprite, "scale", Vector2.ZERO, 0.3)
	await tween_tower.finished
	
	AudioManager.play_sfx(SFX_DEMOLISHING)
	tower.explosion.emitting = true
	await tower.explosion.finished
	
	SignalManager.hud_update.emit()
	
	tower.queue_free()

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
