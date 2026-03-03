class_name GameManager
extends Node

# Serialize Debug Objects
@export var player_info_text		: Label
@export var enemy_info_text			: Label

# Serialize UI Objects
var character_selected		: bool
var selected_character_ui	: Control
#@export var selected_character_icon		: TextureRect # Not used yet
var selected_character_name		: Label

# Player Resources
@export var player_mana 			: int = 0
@export var player_commander_health	: int = 10

# Enemy Resources
@export var enemy_mana				: int = 0
@export var enemy_commander_health	: int = 100

# Game State Management
@export var turn					: bool = 0		# 0 = Player turn, 1 = Enemy turn
@export var camera_is_transitioning	: bool = 0		# 0 = Camera is currently in an animation, 1 = Camera is free

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Initialize variables
	character_selected			= false
	selected_character_ui 		= %"Selected Character Info"
	#selected_character_icon		= %"Selected Character Icon" # Not yet
	selected_character_name		= %"Selected Character Name"
	
	# SetActive false for selected_character_ui
	set_active_selected_character_ui(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Everything that happens when end turn
func end_turn() -> void:
	if (!turn) : end_turn_for_player()
	else : end_turn_for_enemy()
	
	turn = !turn	# Change to other side's turn

func end_turn_for_player() -> void:
	player_mana += 1
	
	# Update debug text
	player_info_text.text = "Player Info  | Mana: %s | Health: %s" % [player_mana, player_commander_health]
	print("Ended turn for player")

func end_turn_for_enemy() -> void:
	enemy_mana += 1
	
	# Update debug text
	enemy_info_text.text = "Enemy Info | Mana: %s | Health: %s" % [enemy_mana, enemy_commander_health]
	print("Ended turn for enemy")


# Set it active/not active in the hiearchy
func set_active_selected_character_ui(set_active : bool) -> void:
	if (!set_active): 
		character_selected = false
		selected_character_ui.hide()
		selected_character_ui.process_mode = Node.PROCESS_MODE_DISABLED
	else: 
		character_selected = true
		selected_character_ui.show()
		selected_character_ui.process_mode = Node.PROCESS_MODE_INHERIT


func toggle_selected_character_ui(unit : Unit) -> void:
	
	# If camera is transitioning can't toggle
	if (camera_is_transitioning): return
	
	selected_character_name.text = unit.unit_name
	
	# Toggle set active of UI elements
	set_active_selected_character_ui(!character_selected)
