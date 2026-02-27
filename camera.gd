extends Camera2D

@export var camera_speed : float = 32;

func _process(delta: float) -> void:
	var axis : Vector2 = Input.get_vector("Left","Right","Up","Down");
	position += axis * delta * camera_speed;
