extends Node

@export var xp : int = 0;
@export var skills : Array[SkillResource];

func _deserialize() -> void:
	
	pass

func _serialize() -> void:
	var save_data : String = JSON.stringify(self);
	var save_file = FileAccess.open("user://debug.sav", FileAccess.WRITE);\
	save_file.store_string(save_data);
	save_file.close();
	
	print(save_data);
