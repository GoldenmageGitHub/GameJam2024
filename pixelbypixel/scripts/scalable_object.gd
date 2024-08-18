extends RigidBody3D

func _ready() -> void:
	$CollisionShape3D.scale = scale
	scale = Vector3.ONE
