class_name EnemyOrbit extends EnemyState

var tower: Tower
var current_angle: float
var current_radius: float
var angular_velocity: float
var target_angular_velocity: float

func enter(msg: Dictionary = {}) -> void:
	tower = msg.tower
	tower.register_orbiting_enemy(enemy)
	
	enemy.state_label.text = enemy.state_machine.current_state.name
	
	enemy.health_bar.hide()
	enemy.animated_sprite.self_modulate = Color.DODGER_BLUE
	
	var vector_to_enemy = enemy.global_position - tower.orbit_center.global_position
	current_angle = vector_to_enemy.angle()
	current_radius = vector_to_enemy.length()
	
	# Relative position and velocity determines the spin direction
	var spin_direction = -1.0 if vector_to_enemy.cross(enemy.velocity) < 0 else 1.0
	
	target_angular_velocity = min(sqrt((GameManager.G * tower.mass) / pow(tower.orbit_radius, 3)) * spin_direction, GameManager.MAX_ORBIT_VELOCITY)
	angular_velocity = (enemy.velocity.length() / max(current_radius, 1.0)) * spin_direction
	
	GameManager.mana += 1
	SignalManager.hud_update.emit()

func exit():
	if is_instance_valid(tower):
		tower.unregister_orbiting_enemy(enemy)

func physics_update(delta: float) -> void:
	if not is_instance_valid(tower):
		enemy.state_machine.transition_to("Die")
		return
		
	# Soft transition between the actual radius and velocity to target radius and velocity
	current_radius = lerp(current_radius, tower.orbit_radius, delta)
	#angular_velocity = lerp(angular_velocity, target_angular_velocity, delta)
	
	current_angle += angular_velocity * delta
	enemy.global_position = tower.orbit_center.global_position + Vector2(cos(current_angle), sin(current_angle)) * current_radius

func get_tangential_velocity() -> Vector2:
	var tangent_dir := Vector2(-sin(current_angle), cos(current_angle))
	return tangent_dir * angular_velocity * current_radius
