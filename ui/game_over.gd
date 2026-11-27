extends CanvasLayer

const MUSIC_GAME_OVER = preload("res://assets/music/Three Red Hearts - Save the City.ogg")
const MUSIC_CONGRATULATIONS = preload("res://assets/music/Three Red Hearts - Sanctuary.ogg")

@onready var lbl_game_over = $PanelContainer/VBoxContainer/LblGameOver


func _ready():
	var music = MUSIC_GAME_OVER
	
	if GameManager.people_town > 0:
		lbl_game_over.text = "Congratulations!"
		music = MUSIC_CONGRATULATIONS
	
	AudioManager.play_music(music)

func _on_btn_try_again_pressed():
	GameManager.restart_game()
	queue_free()
	

func _on_btn_exit_pressed():
	get_tree().quit()
