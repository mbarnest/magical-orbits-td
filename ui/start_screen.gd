extends CanvasLayer


func _on_button_pressed():
	GameManager.start_game()
	queue_free()


func _on_btn_exit_pressed():
	get_tree().quit()
