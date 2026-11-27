class_name Tower extends Node2D

const LEVELS : Dictionary = {
	1: { "radius": 180.0, "mass": 1000.0, "max_attract_mass": 10.0, "upgrade_cost": 0 },
	2: { "radius": 230.0, "mass": 2200.0, "max_attract_mass": 20.0, "upgrade_cost": 500 },
	3: { "radius": 300.0, "mass": 4200.0, "max_attract_mass": 30.0, "upgrade_cost": 750 },
}
const ORBIT_MARGIN: int = 32

@export var orbit_radius: float

var level: int = 1
var mass: float
var max_attract_mass: float
var orbiting_enemies: Array[Enemy]
var demolish_tower: int = 1

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var state_menu: Control = $StateMenu
@onready var range_shape: CollisionShape2D = $TowerRange/RangeShape
@onready var range_color: Sprite2D = $TowerRange/RangeColor
@onready var orbit_center: Marker2D = $TowerRange/OrbitCenter
@onready var base_sprite: Sprite2D = $BaseSprite
@onready var gem_sprite: AnimatedSprite2D = $GemSprite
@onready var btn_target: TextureButton = $BtnTarget
@onready var btn_upgrade: TextureButton = $StateMenu/BtnUpgrade
@onready var btn_demolish: TextureButton = $StateMenu/BtnDemolish
@onready var load_bar: ProgressBar = $LoadBar
@onready var tower_range = $TowerRange
@onready var explosion = $Explosion
@onready var btn_tower = $BtnTower


func _ready() -> void:
	state_label.visible = GameManager.show_debug
	SignalManager.transfer_mode_changed.connect(_on_transfer_mode_changed)
	SignalManager.hud_update.connect(_update_upgrade_button)
	
	apply_level_stats()


func upgrade() -> void:
	level += 1
	apply_level_stats()
	SignalManager.towers_changed.emit()
	
	GameManager.mana -= get_upgrade_cost()
	SignalManager.hud_update.emit()


func apply_level_stats() -> void:
	var stats: Dictionary = LEVELS[level]
	mass = stats.mass
	max_attract_mass = stats.max_attract_mass
	load_bar.max_value = max_attract_mass
	orbit_radius = stats.radius - ORBIT_MARGIN
	range_shape.shape.radius = stats.radius

	var tex_radius: float = range_color.texture.get_width() * 0.5
	range_color.scale = Vector2.ONE * (stats.radius / tex_radius)

	base_sprite.frame = level - 1
	gem_sprite.play("idle_lvl%d" % level)
	btn_upgrade.visible = level < LEVELS.size()


func get_range_radius() -> float:
	return range_shape.shape.radius


func set_range_color(color: Color) -> void:
	range_color.modulate = color


func register_orbiting_enemy(enemy: Enemy) -> void:
	orbiting_enemies.append(enemy)
	load_bar.value += enemy.mass


func unregister_orbiting_enemy(enemy: Enemy) -> void:
	load_bar.value -= enemy.mass
	orbiting_enemies.erase(enemy)


func toggle_menu() -> void:
	demolish_tower = 1
	btn_demolish.modulate = Color.WHITE

	state_menu.visible = !state_menu.visible
	if state_menu.visible:
		btn_upgrade.tooltip_text = "Upgrade. Cost: " + str(get_upgrade_cost())
		_update_upgrade_button()
		move_to_front()


func select_state(state_name: String, msg: Dictionary = {}) -> void:
	state_machine.transition_to(state_name, msg)
	state_menu.hide()
	#toggle_menu()

func get_upgrade_cost() -> int:
	if level < LEVELS.size():
		return LEVELS[level + 1].upgrade_cost
	return 0

func _on_transfer_mode_changed(is_active: bool, origin: Tower) -> void:
	if origin.global_position.distance_to(global_position) > origin.get_range_radius():
		btn_target.visible = is_active and origin != self


func _on_range_area_entered(area: Area2D) -> void:
	if area.state_machine.current_state.name == "Move" and load_bar.max_value >= load_bar.value + area.mass:
		area.state_machine.transition_to("Attracted", {"tower": self})


func _on_range_area_exited(area: Enemy) -> void:
	if area.state_machine.current_state.name == "Attracted" and area.state_machine.current_state.tower == self:
		area.state_machine.transition_to("Move")


func _on_btn_tower_pressed() -> void:
	toggle_menu()


func _on_btn_attacking_pressed() -> void:
	select_state("Attacking")


func _on_btn_orbiting_pressed() -> void:
	select_state("Orbiting")


func _on_btn_transferring_pressed() -> void:
	select_state("Transferring", {"previous_state": state_machine.current_state.name})


func _on_btn_target_pressed() -> void:
	SignalManager.target_selected.emit(self)
	btn_target.hide()


func _on_btn_upgrade_pressed() -> void:
	upgrade()
	toggle_menu()


func _on_btn_demolish_pressed():
	match demolish_tower:
		1:
			demolish_tower += 1
			btn_demolish.modulate = Color.ORANGE
		2:
			demolish_tower += 1
			btn_demolish.modulate = Color.FIREBRICK
		3:
			select_state("Demolishing")


func _on_tree_exited():
	SignalManager.towers_changed.emit()

func _update_upgrade_button() -> void:
	btn_upgrade.disabled = GameManager.mana < get_upgrade_cost()
	
	if btn_upgrade.disabled:
		btn_upgrade.modulate = Color.WEB_GRAY
	else:
		btn_upgrade.modulate = Color.WHITE
