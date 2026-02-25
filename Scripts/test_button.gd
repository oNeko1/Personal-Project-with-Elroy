extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#===========================
# vv TESTING STUFF HERE vv
#===========================
@export_file() var scene_to_go_to_path: String

func _testing_thingys() -> void:
	print("HELLO")

func _testing_thingy(text_: String) -> void:
	print(text_)
	
func _change_scene() -> void:
	get_tree().change_scene_to_file(scene_to_go_to_path)

func _on_button_down() -> void:
	pass # Replace with function body.
