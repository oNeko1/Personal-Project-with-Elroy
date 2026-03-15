extends Control

const levels_directory : String = "res://levels/";
var levels : Array[PackedScene]

@onready var levels_container: VBoxContainer = $Levels
@onready var skill_tree: Panel = $"Skill Tree"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_files = DirAccess.get_files_at(levels_directory);
	for file in level_files:
		var level_file_full_path : String = "%s%s" % [levels_directory, file];
		print(level_file_full_path);
		
		var level_data : PackedScene = load(level_file_full_path);
		if (level_data.can_instantiate() == false):
			printerr("Level cannot be instantiated");
			continue;
		
		levels.append(level_data);
		
		var button : Button = Button.new();
		button.text = file;
		button.pressed.connect(load_level_callback.bind(level_data));
		levels_container.add_child(button);

func load_level_callback(scene : PackedScene) -> void:
	get_tree().change_scene_to_packed(scene);

func skill_tree_visibility(visibility : bool) -> void:
	skill_tree.visible = visibility;
