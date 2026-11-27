extends CanvasLayer

@onready var lbl_game_over = $PanelContainer/VBoxContainer/LblGameOver


func _ready():
	if GameManager.people_town > 0:
		lbl_game_over.text = "Congratulations!"

func _on_btn_try_again_pressed():
	GameManager.restart_game()
	queue_free()
	

func _on_btn_exit_pressed():
	get_tree().quit()
