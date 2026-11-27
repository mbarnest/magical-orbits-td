extends Node

const SCENE_START = preload("res://ui/start_screen.tscn")
const SCENE_PAUSE = preload("res://ui/pause.tscn")
const SCENE_GAME_OVER = preload("res://ui/game_over.tscn")

const G: float = 10000.0

const TOWER_MIN_DISTANCE: float = 80.0
const TOWER_PRICE: int = 1000
const MAX_TRANSFER_SPEED:float = 1500.0
const MAX_ORBIT_VELOCITY: float = 20.0

var show_debug: bool
var people_town: int
var mana: int
var wave: int
var wave_total: int

func start_game() -> void:
	show_debug = false
	people_town = 100 
	mana = 3000
	
	get_tree().paused = false


func restart_game() -> void:
	get_tree().reload_current_scene()

func game_over() -> void:
	get_tree().paused = true
	var screen_game_over_instance: Node = SCENE_GAME_OVER.instantiate()
	add_child(screen_game_over_instance)


func pause() -> void:
	get_tree().paused = true
	var screen_game_over_instance: Node = SCENE_PAUSE.instantiate()
	add_child(screen_game_over_instance)


func resume() -> void:
	get_tree().paused = false
