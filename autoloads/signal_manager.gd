extends Node

@warning_ignore_start("unused_signal")

signal transfer_mode_changed(is_active: bool, source_tower: Tower)
signal target_selected(target_tower: Tower)
signal transfer_cancelled()
signal towers_changed()
signal build_mode_active(is_active: bool)
signal tower_demolished(demolished_tower: Tower)
signal hud_update()
