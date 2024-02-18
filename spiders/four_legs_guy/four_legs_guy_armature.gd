extends Node3D


@export var guy: Node3D
@onready var _prev_position = guy.transform.origin
#@onready var _per_leg_loop_duration: float = guy.leg_individual_stepping_time * 2

@export var ground_offset := 0.5


func _ready() -> void:
	set_as_top_level(true)


func _process(delta: float) -> void:
#	interpolate the armature to guy's position plus some y offset
	var velocity = guy.transform.origin - _prev_position
	var target_origin = guy.transform.origin + guy.transform.basis.y * ground_offset
	transform.origin = lerp(transform.origin, target_origin, delta * guy.move_speed)
	_prev_position = guy.transform.origin
	
	transform.basis = transform.basis.slerp(guy.transform.basis, delta)


func _calculate_body_height(delta) -> void:
	pass

#func _calculate_body_height(delta) -> void:
#	var avg = (fl_ik_target.get_offsetted_local_position() + fr_ik_target.get_offsetted_local_position() + bl_ik_target.get_offsetted_local_position() + br_ik_target.get_offsetted_local_position()) / 4
##	var target_pos = avg + armature.transformed.basis.y * ground_offset
##	var distance = armature.transform.basis.y.dot(target_pos - armature.transform.origin)
##	armature.transform.origin = lerp(armature.transform.origin, armature.transform.origin + armature.transform.basis.y * distance, move_speed * delta)
#	var target_pos = avg + Vector3.UP * ground_offset
#	var distance = transform.basis.y.dot(target_pos - transform.origin)
##	armature.transform.origin = lerp(armature.transform.origin, armature.transform.origin + Vector3.UP * distance, move_speed * delta)
#
#
#func _calculate_body_rotation(delta) -> void:
#	var fr_transform = fr_ik_target.transform.origin
#	var fl_transform = fl_ik_target.transform.origin
#	var br_transform = br_ik_target.transform.origin
#	var bl_transform = bl_ik_target.transform.origin
#
#	var first_normal = _get_triangle_normal(fr_transform, fl_transform, br_transform)
#	var second_normal = _get_triangle_normal(bl_transform, br_transform, fl_transform)
#	var avg_normal = ((first_normal + second_normal) / 2).normalized()
#	var target_basis = _basis_from_normal(avg_normal)
##	armature.transform.basis = lerp(armature.transform.basis.orthonormalized(), target_basis.orthonormalized(), move_speed * delta).orthonormalized()























