class_name WaveLoader

const SCENES: Dictionary = {
	"leafbug": preload("res://entities/enemies/units/leafbug.tscn"),
	"voidbutterfly": preload("res://entities/enemies/units/voidbutterfly.tscn"),
	"firebug": preload("res://entities/enemies/units/firebug.tscn"),
	"locust": preload("res://entities/enemies/units/flying_locust.tscn"),
	"firewasp": preload("res://entities/enemies/units/firewasp.tscn"),
	"clampbeetle": preload("res://entities/enemies/units/clampbeetle.tscn"),
	"magma_crab": preload("res://entities/enemies/units/magma_crab.tscn"),
	"scorpion": preload("res://entities/enemies/units/scorpion.tscn"),
}


static func make_group(enemy_key: String, count: int, interval: float) -> SpawnGroup:
	var group: SpawnGroup = SpawnGroup.new()
	group.enemy_scene = SCENES[enemy_key]
	group.count = count
	group.interval = interval
	return group


static func make_wave(delay: float, groups: Array[SpawnGroup]) -> WaveData:
	var wave: WaveData = WaveData.new()
	wave.initial_delay = delay
	wave.groups = groups
	return wave


static func create_waves() -> Array[WaveData]:
	return [
		# Wave 1
		make_wave(0.5, [
			make_group("leafbug", 30, 0.20),
			make_group("voidbutterfly", 30, 0.10),
			make_group("leafbug", 30, 0.20),
		]),
		make_wave(3.0, [
			make_group("leafbug", 40, 0.20),
			make_group("voidbutterfly", 40, 0.10),
			make_group("leafbug", 40, 0.20),
		]),
		make_wave(3.0, [
			make_group("leafbug", 50, 0.20),
			make_group("voidbutterfly", 50, 0.10),
			make_group("leafbug", 50, 0.20),
		]),
		make_wave(3.0, [
			make_group("leafbug", 60, 0.20),
			make_group("voidbutterfly", 60, 0.10),
			make_group("leafbug", 60, 0.20),
		]),
		
		
		
		# Wave 5
		make_wave(3.0, [
			make_group("voidbutterfly", 100, 0.10),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("voidbutterfly", 100, 0.10),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("voidbutterfly", 100, 0.10),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("voidbutterfly", 100, 0.10),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("voidbutterfly", 100, 0.10),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 10
		make_wave(3.0, [
			make_group("locust", 200, 0.02),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("locust", 200, 0.02),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("locust", 200, 0.02),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("locust", 200, 0.02),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("locust", 200, 0.02),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 15
		make_wave(3.0, [
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 20
		make_wave(3.0, [
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 25
		make_wave(3.0, [
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 30
		make_wave(3.0, [
			make_group("scorpion", 100, 0.05),
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("scorpion", 100, 0.05),
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("scorpion", 100, 0.05),
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("scorpion", 100, 0.05),
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		make_wave(3.0, [
			make_group("scorpion", 100, 0.05),
			make_group("magma_crab", 100, 0.05),
			make_group("clampbeetle", 100, 0.05),
			make_group("firewasp", 100, 0.05),
			make_group("locust", 100, 0.05),
			make_group("firebug", 100, 0.05),
			make_group("voidbutterfly", 100, 0.05),
		]),
		
		
		
		# Wave 35
		make_wave(3.0, [
			make_group("voidbutterfly", 200, 0.01),
			make_group("firebug", 200, 0.01),
			make_group("locust", 200, 0.01),
			make_group("firewasp", 200, 0.01),
			make_group("clampbeetle", 200, 0.01),
			make_group("magma_crab", 200, 0.01),
			make_group("scorpion", 200, 0.01),
			make_group("magma_crab", 200, 0.01),
			make_group("clampbeetle", 200, 0.01),
			make_group("firewasp", 200, 0.01),
			make_group("locust", 200, 0.01),
			make_group("firebug", 200, 0.01),
			make_group("voidbutterfly", 200, 0.01),
		]),
	]
