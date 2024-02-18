extends Marker3D

@export var guy: Node3D
@export var ik_ray: RayCast3D
@export var adjacent_target: Marker3D

@onready var _step_distance = guy.leg_step_distance
@onready var _leg_stepping_time = guy.leg_individual_stepping_time
var _leg_down_offset := position.y
var is_stepping := false
var _up_offsetted_ray_point: Vector3
var _target_basis: Basis

var _stepping_time_interpolation_level := 0.0
var _step_start_relative_center: Vector3
var _step_end_relative_center: Vector3
var _step_center_pivot: Vector3


func _ready() -> void:
	set_as_top_level(true)


func _process(delta: float) -> void:
	if not is_stepping:
		if not ik_ray.is_colliding(): return
		_up_offsetted_ray_point = ik_ray.get_point() + guy.transform.basis.y * _leg_down_offset
		if transform.origin.distance_to(_up_offsetted_ray_point) > _step_distance and not is_stepping and not adjacent_target.is_stepping:
			prepare_for_stepping()

	if is_stepping:
		# get the center position between ik_target and ik_ray_position
		var start_relative_center = _step_start_relative_center
		transform.origin = start_relative_center.slerp(_step_end_relative_center, _stepping_time_interpolation_level) + _step_center_pivot
#		transform.basis = transform.basis.slerp(_target_basis, _stepping_time_interpolation_level)
		if _stepping_time_interpolation_level >= 1.0:
			is_stepping = false


func prepare_for_stepping():
	is_stepping = true
	_stepping_time_interpolation_level = 0.0
	
	var start = transform.origin
	var end = _up_offsetted_ray_point
	var pivot_offset = .1 # lower means higher curve
	_step_center_pivot = (start + end) * .5
	_step_center_pivot -= Vector3(0.0, pivot_offset, 0.0)
	_step_start_relative_center = start - _step_center_pivot
	_step_end_relative_center = end - _step_center_pivot
	
	_target_basis = _basis_from_normal(-ik_ray.get_collision_normal())
	
	var tween = get_tree().create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(self, "_stepping_time_interpolation_level", 1.0, _leg_stepping_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE) # 1 means full slerp interpolatio
	tween.tween_callback(func(): _stepping_time_interpolation_level = 1.0)
	
#	var target_basis = _basis_from_normal(-ik_ray.get_collision_normal()) # negative so it's pointing downward
#	tween.tween_callback(func(): transform.basis = target_basis)
#	tween.tween_callback(func(): is_stepping = false)


func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.y = normal
	result.x = Vector3.FORWARD.cross(normal)
	result.z = result.x.cross(normal)

	return result.orthonormalized()


func get_offsetted_local_position():
	return Vector3(position.x, position.y - _leg_down_offset, position.z)

