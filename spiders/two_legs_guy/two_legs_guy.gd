extends Node3D


@export var move_speed := 4.0
@export var rotate_speed := 1.0
@export var leg_step_distance := 4.5
@export var stepping_bounciness := 2.0

@onready var _ray_container := $RayContainer

@onready var r_ray := $RayContainer/R_Ray
@onready var l_ray := $RayContainer/L_Ray

var _walking_leg_step_distance = leg_step_distance
var leg_individual_stepping_time := leg_step_distance / move_speed / 2.0 # divided my 2 due to '2 steps per loop'


func _process(delta: float) -> void:
	translate(Vector3.BACK * move_speed * delta)
	
	var average_ray_point = (r_ray.get_point() + l_ray.get_point()) / 2
#	get y position from guy
	transform.origin.y = average_ray_point.y
#	calculate the average basis and interpolate the body to it
	var p_target = r_ray.get_point().direction_to(l_ray.get_point())
	var v_x = p_target
	var v_y = Vector3.BACK.cross(v_x)
	var v_z = v_x.cross(v_y)
	var target_basis = Basis(v_x, v_y, v_z)
	transform.basis = lerp(transform.basis, target_basis, delta).orthonormalized()





#func _calculate_body_height(delta) -> void:
#	var avg = (l_ik_target.get_offsetted_origin() + r_ik_target.get_offsetted_origin()) / 2
#	var target_pos = avg + transform.basis.y * ground_offset
#	var distance = transform.basis.y.dot(target_pos - transform.origin)
##	transform.origin = transform.origin + transform.basis.y * distance
#	transform.origin = transform.origin.lerp(transform.origin + transform.basis.y * distance, move_speed * delta)
#
#
#func _calculate_body_rotation(delta) -> void:
#	var r_transform = r_ik_target.transform.origin
#	var l_transform = l_ik_target.transform.origin
#	var p_target = Vector3(r_transform.x, r_transform.y, 0).direction_to(Vector3(l_transform.x, l_transform.y, 0))
#	var v_x = p_target
#	var v_y = Vector3.BACK.cross(v_x)
#	var v_z = v_x.cross(v_y)
#	var target_basis = Basis(v_x, v_y, v_z)
#	global_transform.basis = lerp(transform.basis, target_basis, delta * move_speed).orthonormalized()
#












