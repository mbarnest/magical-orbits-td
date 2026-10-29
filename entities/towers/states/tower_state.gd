class_name TowerState extends State

# Reference to the tower root node
var tower: Tower

func _ready():
	await owner.ready
	tower = owner as Tower
