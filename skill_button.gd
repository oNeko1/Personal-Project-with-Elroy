class_name SkillButton
extends TextureButton


# Debug
@export var skill	: Callable = func(): pass # Start off as an empty function


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	
	# Call the skill callback
	if (skill != null):
		skill.call()
	else:
		assert(false, "Callable: skill, in skill_button.gd is null!")
