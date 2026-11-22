extends CanvasLayer


func _on_btn_resume_pressed():
	GameManager.resume()
	queue_free()


func _on_btn_exit_pressed():
	get_tree().quit()
