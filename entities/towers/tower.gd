class_name Tower extends Node2D

@export_range(1,3) var level: int = 1
@export var mass: float
@export var orbit_radius: float

var orbiting_enemies: Array[Enemy] = []
var range_color: Color = Color.TRANSPARENT

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var state_menu: Control = $StateMenu
@onready var tower_range = $TowerRange
@onready var range_shape = $TowerRange/RangeShape
@onready var orbit_center: Marker2D = $TowerRange/OrbitCenter
@onready var btn_target = $btnTarget

func _ready() -> void:
	SignalManager.transfer_mode_changed.connect(_on_transfer_mode_changed)
	
func _on_transfer_mode_changed(is_active: bool, origin: Tower) -> void:
	if is_active and origin != self:
		btn_target.show()
	else:
		btn_target.hide()

func _on_tower_clicked(clicked_tower: Tower) -> void:
	if clicked_tower != self:
		state_menu.hide()

func _on_deselect_requested() -> void:
	state_menu.hide()

func register_orbiting_enemy(enemy: Enemy) -> void:
	orbiting_enemies.append(enemy)

func unregister_orbiting_enemy(enemy: Enemy) -> void:
	orbiting_enemies.erase(enemy)

func _on_range_area_entered(area):
	if area.state_machine.current_state.name == "Move":
		area.state_machine.transition_to("Attracted", {"tower": self})

func _on_range_area_exited(area):
	if area.state_machine.current_state.name == "Attracted":
		area.state_machine.transition_to("Move")

func toggle_menu() -> void:
	state_menu.visible = !state_menu.visible
	state_label.text = state_machine.current_state.name

func _on_btn_attacking_pressed():
	state_machine.transition_to("Attacking")
	toggle_menu()

func _on_btn_orbiting_pressed():
	state_machine.transition_to("Orbiting")
	toggle_menu()

func _on_btn_transferring_pressed():
	state_machine.transition_to("Transferring", {"previous_state": str(state_machine.current_state.name)})
	toggle_menu()

func set_range_color(color: Color) -> void:
	range_color = color
	queue_redraw()

func _draw() -> void:
	draw_circle(tower_range.position, range_shape.shape.radius, range_color)

func _on_btn_target_pressed():
	SignalManager.target_selected.emit(self)
	btn_target.hide()

func _on_btn_tower_pressed():
	toggle_menu()
