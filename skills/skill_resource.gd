extends Resource
class_name SkillResource

## XP Cost to unlock
@export_category("Statistics")
@export var skill_name : StringName;
@export var xp_cost : int;
@export var damage : int;
@export var mana_cost : int;

@export_category("Resources")
@export var icon : CompressedTexture2D;
