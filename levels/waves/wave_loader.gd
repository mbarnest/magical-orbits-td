class_name WaveLoader

const SCENES: Dictionary = {
	"firebug": preload("res://entities/enemies/units/firebug.tscn"),
	"leafbug": preload("res://entities/enemies/units/leafbug.tscn"),
	"locust": preload("res://entities/enemies/units/flying_locust.tscn"),
	"scorpion": preload("res://entities/enemies/units/scorpion.tscn"),
	"firewasp": preload("res://entities/enemies/units/firewasp.tscn"),
	"clampbeetle": preload("res://entities/enemies/units/clampbeetle.tscn"),
	"voidbutterfly": preload("res://entities/enemies/units/voidbutterfly.tscn"),
	"magma_crab": preload("res://entities/enemies/units/magma_crab.tscn"),
}


static func make_group(enemy_key: String, count: int, interval: float) -> SpawnGroup:
	var group: SpawnGroup = SpawnGroup.new()
	group.enemy_scene = SCENES[enemy_key]
	group.count = count
	group.interval = interval
	return group


static func make_wave(delay_after: float, groups: Array[SpawnGroup]) -> WaveData:
	var wave: WaveData = WaveData.new()
	wave.delay_after_wave = delay_after
	wave.groups = groups
	return wave


static func create_waves() -> Array[WaveData]:
	return [
		make_wave(6.0, [make_group("firebug", 6, 1.6)]),
		make_wave(6.0, [make_group("firebug", 9, 1.4)]),
		make_wave(6.0, [make_group("firebug", 6, 1.3), make_group("leafbug", 2, 1.8)]),
		make_wave(5.5, [make_group("locust", 8, 1.1), make_group("firebug", 3, 1.2)]),
		make_wave(5.5, [make_group("leafbug", 4, 1.5), make_group("firebug", 6, 1.1)]),
		make_wave(5.5, [make_group("locust", 10, 0.9), make_group("leafbug", 4, 1.4)]),
		make_wave(5.0, [make_group("scorpion", 4, 1.3), make_group("firebug", 6, 1.0)]),
		make_wave(5.0, [make_group("scorpion", 6, 1.1), make_group("locust", 6, 0.9)]),
		make_wave(5.0, [make_group("firewasp", 5, 1.1), make_group("firebug", 6, 1.0)]),
		make_wave(5.0, [make_group("scorpion", 6, 1.0), make_group("leafbug", 4, 1.3), make_group("firewasp", 4, 1.0)]),
		make_wave(5.0, [make_group("locust", 12, 0.85), make_group("firewasp", 6, 0.95)]),
		make_wave(4.5, [make_group("scorpion", 8, 0.95), make_group("firewasp", 6, 0.9)]),
		make_wave(4.5, [make_group("clampbeetle", 2, 1.6), make_group("firebug", 8, 0.9)]),
		make_wave(4.5, [make_group("clampbeetle", 3, 1.5), make_group("scorpion", 6, 0.95)]),
		make_wave(4.5, [make_group("firewasp", 8, 0.85), make_group("clampbeetle", 4, 1.4)]),
		make_wave(4.5, [make_group("clampbeetle", 4, 1.3), make_group("scorpion", 8, 0.9), make_group("firewasp", 6, 0.85)]),
		make_wave(4.5, [make_group("magma_crab", 1, 1.5), make_group("firebug", 10, 0.8)]),
		make_wave(4.5, [make_group("magma_crab", 1, 1.5), make_group("clampbeetle", 6, 1.2)]),
		make_wave(4.0, [make_group("locust", 15, 0.7), make_group("firewasp", 8, 0.75), make_group("clampbeetle", 2, 1.2)]),
		make_wave(4.0, [make_group("magma_crab", 2, 1.8), make_group("scorpion", 8, 0.8)]),
		make_wave(4.0, [make_group("voidbutterfly", 2, 1.3), make_group("locust", 10, 0.7)]),
		make_wave(4.0, [make_group("voidbutterfly", 3, 1.2), make_group("clampbeetle", 6, 1.1)]),
		make_wave(4.0, [make_group("magma_crab", 2, 1.6), make_group("voidbutterfly", 4, 1.1), make_group("firewasp", 6, 0.75)]),
		make_wave(4.0, [make_group("magma_crab", 3, 1.5), make_group("clampbeetle", 6, 1.0), make_group("scorpion", 8, 0.75)]),
		make_wave(4.0, [make_group("firewasp", 12, 0.65), make_group("voidbutterfly", 6, 0.9)]),
		make_wave(4.0, [make_group("magma_crab", 4, 1.3), make_group("clampbeetle", 8, 0.95)]),
		make_wave(3.5, [make_group("scorpion", 15, 0.6), make_group("firewasp", 10, 0.65), make_group("voidbutterfly", 4, 0.85)]),
		make_wave(3.5, [make_group("magma_crab", 5, 1.2), make_group("leafbug", 10, 0.7), make_group("clampbeetle", 6, 0.9)]),
		make_wave(3.5, [make_group("voidbutterfly", 8, 0.8), make_group("locust", 15, 0.55), make_group("firewasp", 8, 0.6)]),
		make_wave(3.5, [make_group("magma_crab", 6, 1.1), make_group("voidbutterfly", 8, 0.8)]),
		make_wave(3.5, [make_group("clampbeetle", 10, 0.75), make_group("scorpion", 12, 0.6), make_group("firewasp", 10, 0.55)]),
		make_wave(3.5, [make_group("magma_crab", 7, 1.0), make_group("voidbutterfly", 8, 0.75), make_group("clampbeetle", 8, 0.8)]),
		make_wave(3.5, [make_group("firewasp", 20, 0.45), make_group("voidbutterfly", 10, 0.65)]),
		make_wave(3.5, [make_group("magma_crab", 8, 0.95), make_group("clampbeetle", 12, 0.7)]),
		make_wave(3.5, [make_group("scorpion", 15, 0.5), make_group("voidbutterfly", 12, 0.6), make_group("clampbeetle", 10, 0.7)]),
		make_wave(3.5, [make_group("magma_crab", 10, 0.85), make_group("firewasp", 15, 0.45)]),
		make_wave(3.5, [make_group("voidbutterfly", 15, 0.55), make_group("clampbeetle", 15, 0.6)]),
		make_wave(3.5, [make_group("magma_crab", 12, 0.8), make_group("voidbutterfly", 12, 0.55), make_group("scorpion", 12, 0.45)]),
		make_wave(3.5, [make_group("firewasp", 25, 0.35), make_group("voidbutterfly", 15, 0.5), make_group("magma_crab", 10, 0.75)]),
		make_wave(3.5, [make_group("magma_crab", 15, 0.7), make_group("voidbutterfly", 15, 0.45), make_group("clampbeetle", 15, 0.5), make_group("firewasp", 15, 0.35)]),
	]
