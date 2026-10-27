class_name EnemyState extends State

# Reference to the enemy root node
var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "EnemyState script must be used within an Enemy scene.")
