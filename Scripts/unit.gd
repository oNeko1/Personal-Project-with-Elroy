class_name Unit
extends MeshInstance3D

# Common variables
@export var unit_name		: String = "undefined"
@export var health			: int = 100
@export var attack_power	: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_mouse_entered() -> void:
	pass

func _on_area_3d_mouse_exited() -> void:
	pass


# Onclick by mouse
func _on_area_3d_input_event(camera: Node, 
event: InputEvent, 
event_position: Vector3, 
normal: Vector3, shape_idx: int) -> void:
	
	# On hover over the object and clicked
	if (event is InputEventMouseButton and 
	event.is_action_pressed("Mouse Down")):
		
		# Call GameManager toggle_selected_character_ui
		if (%"Game Manager".has_method("toggle_selected_character_ui")):
			%"Game Manager".toggle_selected_character_ui(self)
		else : 
			assert(false, "%GameManager does not have toggle_selected_character_ui 
			function (SHOULD NOT HAPPEN)")
		
		# Call camera_controller zoom_into function
		if (camera.has_method("toggle_zoom")):
			camera.toggle_zoom(self)
		else : 
			assert(false, "camera does not have toggle_zoom 
			function (SHOULD NOT HAPPEN)")
