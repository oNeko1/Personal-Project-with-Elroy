class_name CommanderUnit
extends Unit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	have_skill = [1, 1, 0]
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)


# Debug skill that does nothing
func skill_1() -> void:
	super.skill_1()


# Debug skill to spawn unit
func skill_2() -> void:
	super.skill_2()
