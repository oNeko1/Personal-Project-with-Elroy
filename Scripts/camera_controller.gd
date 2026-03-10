extends Node

# Vars
var game_manager		: GameManager # Reference to %"Game Manager"
var initial_position	: Vector3		# Initial position of the camera at the start of the scene
var zoomed_in			: bool = false	# True if camera is in zoomed in state
var focused_unit_pos	: Vector3		#Position of the unit the camera is zomomed into (When selected))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Initialize variables
	game_manager 		= %"Game Manager"
	initial_position 	= self.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Immediately set camera_is_transitioning to true
# If any other functions like game_manager.toggle_selected_character_ui()
# requires game_manager.camera_is_transitioning to be false
# then make sure to call this function last
func toggle_zoom(unit : Node3D) -> void:
	
	# If in the middle of Tween zooming in then don't do anything
	if (game_manager.camera_is_transitioning): return
	
	# Zoom in or out based on whether camera is already zoomed into something
	if (!zoomed_in): zoom_into(unit)
	else: zoom_out()
	zoomed_in = !zoomed_in

func zoom_into(unit : Node3D) -> void:
	
	var target_pos = unit.global_position + Vector3(0, 0.5, 1.5)
	game_manager.camera_is_transitioning = true
	
	# Create the Tween and settings
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	
	# "Lerp" the property
	tween.tween_property(self, "global_position", target_pos, 0.5)
	
	# Callback after the lerp
	tween.tween_callback(set_zooming_in.bind(false))
	

func zoom_out() -> void:
	
	# If already not zoomed in then don't do anything
	#if (!zoomed_in): return
	
	var target_pos = initial_position
	game_manager.camera_is_transitioning = true
	
	# Create the Tween and settings
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	
	# "Lerp" the property
	tween.tween_property(self, "global_position", target_pos, 0.5)
	
	# Callback after the lerp
	tween.tween_callback(set_zooming_in.bind(false))


func set_zooming_in(toggle : bool) -> void:
	game_manager.camera_is_transitioning = toggle
