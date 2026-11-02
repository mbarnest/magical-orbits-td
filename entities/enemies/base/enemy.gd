class_name Enemy extends Area2D

@export var speed: float = 100.0
@export var mass: float = 1.0
@export var screen_margin: float = 100.0
@export var health: float = 500000.0

var velocity: Vector2 = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel
@onready var health_bar = $HealthBar

func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(_delta: float) -> void:
	state_label.text = state_machine.current_state.name
	
	var viewport_rect: Rect2 = get_viewport_rect()
	var safe_area: Rect2 = viewport_rect.grow(screen_margin)
	if not safe_area.has_point(global_position):
		queue_free()

func take_damage(amount: float) -> void:
	health -= amount
	health_bar.value = health
	
	if health <= 0:
		state_machine.transition_to("Die")
