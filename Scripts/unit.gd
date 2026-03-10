class_name Unit
extends MeshInstance3D

# Unit stats
@export_group("Unit stats")
@export var unit_name			: String = "undefined"
@export var health				: int = 100
@export var attack_power		: int = 10

# Serialize Nodes
@export_group("Serialize Nodes")
@export var unit_name_label3d	: Label3D

# Unit state control
var unit_currently_selected		: bool = false
@export var unit_turn_done		: bool = false
var is_enemy					: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Set Label3D to unit_name and set active false
	unit_name_label3d.text = unit_name
	set_active_unit_name_label3d(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	
	var camera = %"Main Camera"
		
	# Call GameManager toggle_selected_character_ui
	if (%"Game Manager".has_method("toggle_selected_character_ui")):
		%"Game Manager".toggle_selected_character_ui(self)
	else : 
		assert(false, "%GameManager does not have toggle_selected_character_ui 
		function (SHOULD NOT HAPPEN)")
	
	# Call camera_controller zoom_into function
	if (camera.has_method("toggle_zoom")):
		camera.toggle_zoom(self)
	else : 
		assert(false, "camera does not have toggle_zoom 
		function (SHOULD NOT HAPPEN)")
		
	# Toggle whether unit is currently selected
	unit_currently_selected = !unit_currently_selected
	set_active_unit_name_label3d(unit_currently_selected)


# Debug
# Skill should return true if the unit possesses the skill
# Eg. if a unit has 2 skills then skill_1 and skill_2
# should return true while skill_3 should return false
# STILL WORKING ON THE TRUE FALSE
func test_skill_1() -> bool:
	unit_turn_done = true
	toggle_select_unit()
	return true
