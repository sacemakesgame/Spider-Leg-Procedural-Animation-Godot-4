extends RayCast3D


var _ray_point: Vector3


func _process(delta: float) -> void:
	var hit_position = get_collision_point()
	if hit_position:
		_ray_point = hit_position


func get_point() -> Vector3:
	return _ray_point
