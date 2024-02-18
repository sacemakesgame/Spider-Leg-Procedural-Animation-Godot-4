extends Node3D


@export var guy: Node3D
@onready var _prev_position = guy.transform.origin
@onready var r_ik_target = $"../R_IK_Target"
@onready var l_ik_target = $"../L_IK_Target"

@export var ground_offset := 1.5


func _ready() -> void:
	set_as_top_level(true)


func _process(delta: float) -> void:
#	interpolate the armature to guy's position plus some y offset
	var velocity = guy.transform.origin - _prev_position
	var target_origin = guy.transform.origin + guy.transform.basis.y * ground_offset
	transform.origin.x = lerp(transform.origin.x, target_origin.x, delta)
	transform.origin.z = lerp(transform.origin.z, target_origin.z, delta)
	_prev_position = guy.transform.origin
	
	transform.basis = transform.basis.slerp(guy.transform.basis, delta)
	
	_calculate_body_height(delta)


func _calculate_body_height(delta) -> void:
	var avg = (l_ik_target.get_offsetted_local_position() + r_ik_target.get_offsetted_local_position()) / 2
	var target_pos = avg + transform.basis.y * ground_offset
	var distance = transform.basis.y.dot(target_pos - transform.origin)
#	transform.origin = transform.origin + transform.basis.y * distance
	transform.origin = transform.origin.lerp(transform.origin + transform.basis.y * distance, guy.move_speed * delta)


















