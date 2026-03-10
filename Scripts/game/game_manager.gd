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
@export var skill_buttons		: Array[SkillButton] # Array of skill buttons

# Player Resources
@export_group("Player Resources	")
@export var player_mana 			: int = 0
## Player Commander Health is Fetched from the Commander Unit Node

# Enemy Resources
@export_group("Enemy Resources	")
@export var enemy_mana				: int = 0
## Enemy Commander Health is Fetched from the Commander Unit Node

# Game State Management
@export_group("Game State Management")
@export var turn					: bool = 0		# 0 = Player turn, 1 = Enemy turn
@export var camera_is_transitioning	: bool = 0		# 0 = Camera is currently in an animation, 1 = Camera is free
var unit_currently_selected			: Unit			# Unit that is currently selected by player

# Serialize Nodes
@export_group("Serialize Nodes")
@export var player_units			: Array[Unit]
@export var enemy_units				: Array[Unit]

@onready var player_side: FieldSide = %"Player Side"
@onready var enemy_side: FieldSide = %"Enemy Side"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Initialize variables
	character_selected			= false
	selected_character_ui 		= %"Selected Character Info"
	#selected_character_icon		= %"Selected Character Icon" # Not yet
	selected_character_name		= %"Selected Character Name"
	
	# Initialize all the is_enemy of all units
	for unit in player_units:	# Do for player side
		assert(is_instance_valid(unit))
		unit.add_to_group("Friendly");
		unit.is_enemy = false
	for unit in enemy_units:	# Do for enemy side
		assert(is_instance_valid(unit))
		unit.is_enemy = true
		unit.add_to_group("Hostile");
	
	# Deactivate all the skill buttons initially
	for i in range(skill_buttons.size()):
		toggle_skill_button_at_ready(i, false)
	
	# SetActive false for selected_character_ui
	set_active_selected_character_ui(false)

# Everything that happens when end turn
func end_turn() -> void:
	if (!turn) : end_turn_for_player()
	else : end_turn_for_enemy()
	
	turn = !turn	# Change to other side's turn

func end_turn_for_player() -> void:
	player_mana += 1
	
	# Reset the turns for all units in player's side
	for unit in player_units:
		unit.unit_turn_done = false
	
	# First Child should be Commander
	var commander : Unit = player_side.commander_marker.get_child(0);
	
	# Update debug text
	player_info_text.text = "Player Info  | Mana: %s | Health: %s" % [player_mana, commander.health]
	print("Ended turn for player")


func end_turn_for_enemy() -> void:
	enemy_mana += 1
	
	# Reset the turns for all units in enemy's side
	for unit in enemy_units:
		unit.unit_turn_done = false
		
	var commander : Unit = player_side.commander_marker.get_child(0);
	
	# Update debug text
	enemy_info_text.text = "Enemy Info | Mana: %s | Health: %s" % [enemy_mana, commander.health]
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


# Turn on all the UI necessary for when
# a unit is selected
func toggle_selected_character_ui(unit : Unit) -> void:
	
	# If camera is transitioning can't toggle
	if (camera_is_transitioning): return
	
	# Set the unit to be currently selected/de-select it
	# depending on whether it is already selected
	if (unit_currently_selected != unit):
		unit_currently_selected = unit
		set_active_selected_character_ui(true) # Toggle set active of UI elements
		
		# Activate as many skill buttons as is necessary
		# for the currently selected character
		for i in range(skill_buttons.size()):
			toggle_skill_button(i, true)
	
		selected_character_name.text = unit.unit_name # Debug
		
	else:
		unit_currently_selected = null
		set_active_selected_character_ui(false) # Toggle set active of UI elements
		
		# Activate as many skill buttons as is necessary
		# for the currently selected character
		for i in range(skill_buttons.size()):
			toggle_skill_button(i, false)
		
		# When closing the UI of a unit, it means that a skill might
		# have been used, this is the time to check whether all units
		# have had a turn. If so, change turn to opposing team
		var current_turn_units
		if !turn: # If player turn
			current_turn_units = player_units
			print("PLAYER TURN RN")
		else: 	# If enemy turn
			current_turn_units = enemy_units
			print("ENEMY TURN RN")
		
		# Check through the list of the units of the current turn
		# (Player or enemy)
		for _unit in current_turn_units:
			if !_unit.unit_turn_done: pass
			else: 
				end_turn()
				return


# Used to activate or de-activate the buttons at the start
# of the scene
func toggle_skill_button_at_ready(index : int, active : bool) -> void:
	
	# Show or hide skill button based on "active"
	var skill_button = skill_buttons[index]
	if (skill_button != null):
		if (active): 
			skill_button.show()
			skill_button.process_mode = Node.PROCESS_MODE_INHERIT
		else: 
			skill_button.hide()
			skill_button.process_mode = Node.PROCESS_MODE_DISABLED
	else : 
		assert(false, "skill_buttons[%d] does not exist!" % index)


# Used to set the skill Callable in each skill_button
# and then toggle it to either be active or in-active
# depending on whether the unit has that number of skills
func toggle_skill_button(index : int, active : bool) -> void:
	
	var skill_button = skill_buttons[index]
		
	# Show or hide skill button based on "active"
	if (skill_button != null):
		if (active): 
			skill_button.show()
			skill_button.process_mode = Node.PROCESS_MODE_INHERIT
		else: 
			skill_button.hide()
			skill_button.process_mode = Node.PROCESS_MODE_DISABLED
	else : 
		assert(false, "skill_buttons[%d] does not exist!" % index)
	
	# Set the skill_button to be the skill of the
	# currently selected unit
	if (unit_currently_selected != null):
		skill_button.skill = Callable(unit_currently_selected, "test_skill_1")
	else:
		skill_button.skill = func(): pass # Set the skill to empty lambda
