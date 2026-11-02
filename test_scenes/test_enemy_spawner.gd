extends Marker2D

@export var enemy_scene: PackedScene

func _on_timer_timeout():
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = Vector2(100.0, randf_range(100.0, 1000.0))
	get_parent().add_child(enemy_instance)
