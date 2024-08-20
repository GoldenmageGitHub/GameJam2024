extends CharacterBody3D

@export var shrinking_slowdown: float = 1.0

@onready var sprite: AnimatedSprite3D = $CollisionShape3D/AnimatedSprite3D
@onready var shape = $CollisionShape3D
@onready var music: AudioStreamPlayer = %music

const SPEED = 2.0
const JUMP_VELOCITY = 3.5

var last_direction = false

func _physics_process(delta: float) -> void:
	var scale_value = shape.scale.x
	var scale_effect = 1 - ((1 - scale_value) * shrinking_slowdown)
	var jumped = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * scale_effect

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * scale_effect
		jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * scale_effect
		velocity.z = direction.z * SPEED * scale_effect
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if jumped:
		sprite.play("jump")
	elif is_on_floor():
		if abs(velocity.x) > 0.01 or abs(velocity.z) > 0.01:
			sprite.play("walk")
			last_direction = velocity.x > 0.01
		else:
			sprite.play("idle")
	
	for scale_index in [0,1,2,3,4,5,6,7]:
		var scale_factor = pow(2, scale_index)
		if Input.is_action_just_pressed("debug_scale_" + str(scale_factor)):
			music.get_stream_playback().switch_to_clip(min(scale_index, 3))
			create_tween().tween_property(shape, "scale", Vector3.ONE / scale_factor, 1)
			break
	
	sprite.flip_h = last_direction

	move_and_slide()
