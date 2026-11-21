extends Control

@onready var enemies = $"../Enemies"

@onready var btn_buy_tower = $PanelContainer/HBoxContainer/BtnBuyTower
@onready var btn_exit = $PanelContainer/HBoxContainer/BtnExit

@onready var lbl_mana = $PanelContainer/HBoxContainer/LblMana
@onready var lbl_wave = $PanelContainer/HBoxContainer/LblWave
@onready var lbl_enemies_left = $PanelContainer/HBoxContainer/LblEnemiesLeft
@onready var lbl_enemies_captured = $PanelContainer/HBoxContainer/LblEnemiesCaptured
@onready var lbl_people_town = $PanelContainer/HBoxContainer/LblPeopleTown


func _ready() -> void:
	btn_buy_tower.toggled.connect(SignalManager.build_mode_active.emit)
	SignalManager.build_mode_active.connect(btn_buy_tower.set_pressed_no_signal)
	SignalManager.hud_update.connect(hud_update)

	lbl_mana.text = "Mana: " + str(GameManager.mana)
	

func hud_update() -> void:
	var enemies_left: int = get_tree().get_node_count_in_group("enemies")
	var enemies_total: int = enemies.get_child_count()
	lbl_enemies_left.text = "Enemies Left: " + str(enemies_left)
	lbl_enemies_captured.text = "Enemies Captured: " + str(enemies_total - enemies_left)
	lbl_people_town.text = "People in town: " + str(GameManager.people_town)
