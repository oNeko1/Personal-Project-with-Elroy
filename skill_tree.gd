extends Panel

const skill_directory : String = "res://skills/";

@onready var skill_column: VBoxContainer = $"MarginContainer/Panel/Skill Column"
@onready var xp_label: Label = $"MarginContainer/Panel/Skill Column/XP Label"

func _ready() -> void:
	xp_label.text = "XP: %s" % DataHandler.xp;
	
	load_locked_skills();

func load_locked_skills() -> void:
	var skill_dir_access = DirAccess.open(skill_directory);
	var skill_files = skill_dir_access.get_files();
	for file in skill_files:
		var extension = file.substr(file.length() - 5,5);
		if (extension != ".tres"): continue;
		var full_path : String = "%s%s" % [skill_directory,file];
		
		## Polymorphism Check
		var skill_resource = load(full_path);
		if (skill_resource is not SkillResource): continue;
		
		var btn : SkillUnlockButton = SkillUnlockButton.new();
		btn.skill_resource = skill_resource;
		skill_column.add_child(btn);
		
		print(full_path);
