extends Camera3D

@onready var practical_attributes: CameraAttributesPractical = $".".attributes
@onready var initial_attributes: CameraAttributesPractical = practical_attributes.duplicate()

func _process(delta: float) -> void:
	var scale_value = get_parent_node_3d().scale.x
	practical_attributes.dof_blur_far_distance = initial_attributes.dof_blur_far_distance * scale_value
	practical_attributes.dof_blur_far_transition = initial_attributes.dof_blur_far_transition * scale_value
	practical_attributes.dof_blur_near_distance = initial_attributes.dof_blur_near_distance * scale_value
	practical_attributes.dof_blur_near_transition = initial_attributes.dof_blur_near_transition * scale_value
