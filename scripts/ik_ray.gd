extends RayCast3D


var _y_offset := -target_position.y / 2
var _ik_ray_position: Vector3


func get_updated_ik_ray_position() -> Vector3:
#	transform.basis = _basis_from_normal(get_collision_normal())
	var hit_position = get_collision_point()
	if hit_position:
		_ik_ray_position = hit_position
	return _ik_ray_position


func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.y = normal
	result.x = Vector3.FORWARD.cross(normal)
	result.z = result.x.cross(normal)
	
	return result.orthonormalized()
