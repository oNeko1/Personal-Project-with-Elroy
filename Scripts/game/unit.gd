class_name Unit
extends Node3D

# Unit stats
@export_group("Unit stats")
@export var unit_name			: String = "undefined"
@export var health				: int = 100
@export var attack_power		: int = 10

# If a unit has skill_1 but not skill_2 and skill_3
# Then this should be [1, 0, 0]
@export var have_skill			: Array[int] = [1, 0, 0]

@onready var unit_name_label3d : Label3D = $"Area3D/Unit Name";

# Unit state control
@export_category("State")
var unit_currently_selected		: bool = false
@export var unit_turn_done		: bool = false
var is_enemy					: bool

@onready var game_camera : GameCameraController = get_viewport().get_camera_3d();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Set Label3D to unit_name and set active false
	unit_name_label3d.text = unit_name
	set_active_unit_name_label3d(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(game_camera.global_position);


func _on_area_3d_mouse_entered() -> void:
	
	# When unit is already selected,
	# do not require to show all the stats
	# since they should already be showing
	if (unit_currently_selected) : return
	
	set_active_unit_name_label3d(true)


func _on_area_3d_mouse_exited() -> void:
	
	# When unit is already selected,
	# do not require to remove all stats
	# since they should always be showing while selected
	if (unit_currently_selected) : return
	
	set_active_unit_name_label3d(false)


# Onclick by mouse
func _on_area_3d_input_event(camera: Node, 
event: InputEvent, 
event_position: Vector3, 
normal: Vector3, shape_idx: int) -> void:
	
	# On hover over the object and clicked
	if (event is InputEventMouseButton and 
	event.is_action_pressed("Mouse Down")):
		
		# Ignore selectability if it is not that person's turn
		if (is_enemy != %"Game Manager".turn):
			return
		
		toggle_select_unit()


func on_unit_turn_start() -> void:
	pass


func on_unit_turn_end() -> void:
	pass


# Set it active/not active in the hiearchy
func set_active_unit_name_label3d(set_active : bool) -> void:
	if (!set_active): 
		unit_name_label3d.hide()
		#unit_name_label3d.process_mode = Node.PROCESS_MODE_DISABLED
	else: 
		unit_name_label3d.show()
		#unit_name_label3d.process_mode = Node.PROCESS_MODE_INHERIT


# Toggle select or deselect unit
# should auto deselect after using a skill
# Used to de-select a unit after using a move or after their turn has ended
func toggle_select_unit() -> void:
	
	var game_manager : GameManager = %"Game Manager";
	
	# Call GameManager toggle_selected_character_ui
	game_manager.toggle_selected_character_ui(self)
	
	# Call camera_controller zoom_into function
	game_camera.toggle_zoom(self)
	
	# Toggle whether unit is currently selected
	unit_currently_selected = !unit_currently_selected
	set_active_unit_name_label3d(unit_currently_selected)


# have_skill[skill number - 1] should return true
# If the unit posesses that skill.
func skill_1() -> void:
	unit_turn_done = true
	toggle_select_unit()


func skill_2() -> void:
	unit_turn_done = true
	toggle_select_unit()


func skill_3() -> void:
	unit_turn_done = true
	toggle_select_unit()
