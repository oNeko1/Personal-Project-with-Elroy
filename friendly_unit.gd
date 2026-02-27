extends Node2D

var enemy_base : Node2D;

func _ready() -> void:
	enemy_base = get_tree().get_first_node_in_group("Enemy Base");
	if (is_instance_valid(enemy_base) == false):
		print("No Enemy Base Found");
