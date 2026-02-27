extends MarginContainer

@export var unit_name : String;

func spawn_unit() -> void:
	print("Spawning %s" % unit_name);
