extends Control

@onready var enemies = $"../Enemies"

@onready var btn_buy_tower = $PanelContainer/HBoxContainer/BtnBuyTower
@onready var btn_pause = $PanelContainer/HBoxContainer/BtnPause

@onready var lbl_mana = $PanelContainer/HBoxContainer/LblMana
@onready var lbl_wave = $PanelContainer/HBoxContainer/LblWave
@onready var lbl_enemies_left = $PanelContainer/HBoxContainer/LblEnemiesLeft
@onready var lbl_enemies_captured = $PanelContainer/HBoxContainer/LblEnemiesCaptured
@onready var lbl_people_town = $PanelContainer/HBoxContainer/LblPeopleTown


func _ready() -> void:
	btn_buy_tower.toggled.connect(SignalManager.build_mode_active.emit)
	SignalManager.build_mode_active.connect(btn_buy_tower.set_pressed_no_signal)
	
	SignalManager.hud_update.connect(hud_update)
	
	btn_buy_tower.tooltip_text = "Cost: " + str(GameManager.TOWER_PRICE)
	
	enemies.child_entered_tree.connect(_on_enemies_changed)
	enemies.child_exiting_tree.connect(_on_enemies_changed)

	hud_update()

func hud_update() -> void:
	if not is_inside_tree():
		return
		
	var enemies_left: int = get_tree().get_node_count_in_group("enemies")
	var enemies_total: int = enemies.get_child_count()
	
	lbl_mana.text = "Mana: " + str(GameManager.mana)
	lbl_wave.text = "Wave: " + str(GameManager.wave) + " / " + str(GameManager.wave_total)
	lbl_enemies_left.text = "Enemies Left: " + str(enemies_left)
	lbl_enemies_captured.text = "Enemies Captured: " + str(enemies_total - enemies_left)
	lbl_people_town.text = "People in town: " + str(GameManager.people_town)
	
	btn_buy_tower.disabled = GameManager.mana < GameManager.TOWER_PRICE


func _on_enemies_changed(_node: Node) -> void:
	hud_update.call_deferred()


func _on_btn_pause_pressed():
	GameManager.pause()
