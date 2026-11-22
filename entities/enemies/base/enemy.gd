class_name Enemy extends Area2D

@export var speed: float = 100.0
@export var mass: float = 1.0
@export var health: float = 1000.0
@export var mana: int = 1

var velocity: Vector2 = Vector2.ZERO
var flow_field: FlowField
var screen_size: Rect2
var screen_margin: int = 32

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var health_bar = $HealthBar

func _ready() -> void:
	screen_size = get_viewport_rect().grow(screen_margin)

	state_label.visible = GameManager.show_debug
	health_bar.max_value = health
	health_bar.value = health
	flow_field = get_tree().get_first_node_in_group("flow_field") as FlowField
	
func _physics_process(_delta):
	if screen_size.has_point(global_position):
		return
		
	if state_machine.current_state.name in ["Attracted", "Orbit"]:
		return
	
	if state_machine.current_state.name == "Move":
		GameManager.people_town -= 1
		
		if GameManager.people_town == 0:
			GameManager.game_over()
	
	queue_free()


func take_damage(amount: float) -> void:
	health -= amount
	health_bar.value = health
	
	if health <= 0:
		state_machine.transition_to("Die")
