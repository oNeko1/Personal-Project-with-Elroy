extends Node

# Serialize Objects
@export var player_info_text		: Label
@export var enemy_info_text			: Label

# Player Resources
@export var player_mana 			: int = 0
@export var player_commander_health	: int = 100

# Enemy Resources
@export var enemy_mana				: int = 0
@export var enemy_commander_health	: int = 100

# Game State Management
@export var turn	: bool = 0		# 0 = Player turn, 1 = Enemy turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
