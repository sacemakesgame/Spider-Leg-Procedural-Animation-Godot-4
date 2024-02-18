extends Node3D

@export var guy: Node3D
@export var offset: float = 40
@onready var prev_position = guy.transform.origin
#@onready var prev_rotation = guy.transform.basis
@onready var _per_leg_loop_duration: float = guy.leg_individual_stepping_time * 2 


func _ready() -> void:
	set_as_top_level(true)

func _process(delta: float) -> void:
	var velocity = guy.transform.origin - prev_position
	transform.origin = guy.transform.origin + velocity * _per_leg_loop_duration / delta
	prev_position = guy.transform.origin

#	var rot_velocity = guy.global_rotation - prev_rotation
#	global_rotation = guy.global_rotation + rot_velocity * 0.1/delta * 4
#	prev_rotation = guy.global_rotation
