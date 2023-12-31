extends CharacterBody3D
const SPEED = 5
const JUMP_VELOCITY = 6
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Node3D
@onready var camera := $Node3D/Camera3D
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and 1:
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _input(event):
	if event is InputEventMouseMotion:
		neck.rotate_y(-event.relative.x*0.01)
		camera.rotate_x(-event.relative.y*0.01)
		camera.rotation.x=clamp(camera.rotation.x,deg_to_rad(-90),deg_to_rad(90))
