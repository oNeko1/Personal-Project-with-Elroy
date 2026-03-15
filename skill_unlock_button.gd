extends Button
class_name SkillUnlockButton

@export var skill_resource : SkillResource;

const MSYBAU = preload("uid://dqgotw7arif50")

func _ready() -> void:
	if (is_instance_valid(skill_resource) == false):
		queue_free();
		printerr("Skill Button instantiated without appropriate Skill Resource")
	
	text = skill_resource.skill_name;
	pressed.connect(unlock);

func unlock() -> void:
	if (DataHandler.xp < skill_resource.xp_cost):
		print("Insufficient XP to Unlock");
		return;
	
	AudioHandler.loan_stream(MSYBAU);
	DataHandler.xp -= skill_resource.xp_cost;
	queue_free();
