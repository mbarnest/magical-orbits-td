extends Node2D

func _ready() -> void:
	get_tree().paused = true
	
	var screen_start: Node = GameManager.SCENE_START.instantiate()
	add_child(screen_start)
