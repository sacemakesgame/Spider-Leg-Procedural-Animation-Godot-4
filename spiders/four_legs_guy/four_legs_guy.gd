extends Node3D


@export var move_speed := 1.5
@export var rotate_speed := 1.0
@export var leg_step_distance := 1.0
@export var stepping_bounciness := 2.0

@onready var fr_ray := $RayContainer/FR_Ray
@onready var fl_ray := $RayContainer/FL_Ray
@onready var br_ray := $RayContainer/BR_Ray
@onready var bl_ray := $RayContainer/BL_Ray

var _walking_leg_step_distance = leg_step_distance
var leg_individual_stepping_time := leg_step_distance / move_speed / 2.0 # divided my 2 due to '2 steps per loop'


func _process(delta: float) -> void:
	translate(Vector3.BACK * move_speed * delta)
	
	var average_ray_point = (fr_ray.get_point() + fl_ray.get_point() + br_ray.get_point() + bl_ray.get_point()) / 4
#	get y position from guy
	transform.origin.y = average_ray_point.y
#	calculate the average basis and interpolate the body to it
	var normal = _get_triangle_normal(fr_ray.get_point(), fl_ray.get_point(), br_ray.get_point())
	var target_basis = _basis_from_normal(normal)
	transform.basis = lerp(transform.basis, target_basis, delta).orthonormalized()



func _get_triangle_normal(a: Vector3, b: Vector3, c: Vector3) -> Vector3:
	var side1: Vector3 = a.direction_to(b)
	var side2: Vector3 = a.direction_to(c)
	var normal: Vector3 = side1.cross(side2)
	return normal


func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.y = normal
	result.x = Vector3.FORWARD.cross(normal)
	result.z = result.x.cross(normal)

	return result.orthonormalized()


func _handle_input(delta) -> void:
	var input_direction := Input.get_vector("rotate_right", "rotate_left", "move_backward", "move_forward")
	if input_direction != Vector2.ZERO:
		leg_step_distance = _walking_leg_step_distance
		translate(Vector3(0,0,input_direction.y) * move_speed * delta)
		rotate_object_local(Vector3.UP, input_direction.x * rotate_speed * delta)
	else:
		leg_step_distance = .1
