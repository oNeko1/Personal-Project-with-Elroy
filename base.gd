extends Node2D

@onready var base_name: Label = $Name

func _on_area_2d_mouse_entered() -> void:
	base_name.visible = true;

func _on_area_2d_mouse_exited() -> void:
	base_name.visible = false;
