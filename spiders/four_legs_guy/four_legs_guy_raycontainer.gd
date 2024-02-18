extends Node3D

@export var guy: Node3D
@onready var _prev_position = guy.transform.origin
@onready var _per_leg_loop_duration: float = guy.leg_individual_stepping_time * 2

@onready var fr_ray := $FR_Ray
@onready var fl_ray := $FL_Ray
@onready var br_ray := $BR_Ray
@onready var bl_ray := $BL_Ray

var origin: Vector3
var normal: Vector3

#func _ready() -> void:
#	set_as_top_level(true)
#
#func _process(delta: float) -> void:
##	move slightly towards the guy's walk direction
##	var velocity = guy.transform.origin - _prev_position
##	transform.origin = guy.transform.origin + Vector3(1,0,1) * velocity * _per_leg_loop_duration / delta
##	_prev_position = guy.transform.origin
#
#	var average_ray_point = (fr_ray.get_point() + fl_ray.get_point() + br_ray.get_point() + bl_ray.get_point()) / 4
##	get y position from guy
#	transform.origin.y = average_ray_point.y
#
#	normal = _get_triangle_normal(fr_ray.get_point(), fl_ray.get_point(), br_ray.get_point())
#	transform.basis = _basis_from_normal(normal)


#
#func _get_triangle_normal(a: Vector3, b: Vector3, c: Vector3) -> Vector3:
#	var side1: Vector3 = a.direction_to(b)
#	var side2: Vector3 = a.direction_to(c)
#	var normal: Vector3 = side1.cross(side2)
#	return normal
#
#
#func _basis_from_normal(normal: Vector3) -> Basis:
#	var result = Basis()
#	result.y = normal
#	result.x = Vector3.FORWARD.cross(normal)
#	result.z = result.x.cross(normal)
#
#	return result.orthonormalized()
