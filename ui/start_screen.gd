extends CanvasLayer

const MUSIC = preload("res://assets/music/Three Red Hearts - Three Red Hearts.ogg")


func _ready() -> void:
	AudioManager.play_music(MUSIC)

func _on_button_pressed():
	GameManager.start_game()
	queue_free()


func _on_btn_exit_pressed():
	get_tree().quit()
