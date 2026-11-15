extends Control

@onready var btn_buy_tower: Button = $HBoxContainer/btnBuyTower

func _ready() -> void:
	btn_buy_tower.toggled.connect(SignalManager.build_mode_active.emit)
	SignalManager.build_mode_active.connect(btn_buy_tower.set_pressed_no_signal)
