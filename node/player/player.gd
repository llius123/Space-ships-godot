extends CharacterBody2D

var GlobalConfig = preload("res://scripts/config.gd").new()

var SPEED = GlobalConfig.PLAYER_SPEED
var PLAYER_VELOCITY = Vector2.ZERO
var was_pressed = false
var was_pressed_progress_bar = false
var bullet_sprite = preload("res://node/bullet/bullet.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	name = "PLAYER"
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot_bullet()


func _process(delta):
	move(delta)
	rotate_player()
	mouse_click()


func move(delta: float):
	PLAYER_VELOCITY = Vector2.ZERO
	# Check for key presses and adjust velocity.
	if Input.is_key_pressed(KEY_W):  # Move up
		PLAYER_VELOCITY.y -= 1
	if Input.is_key_pressed(KEY_S):  # Move down
		PLAYER_VELOCITY.y += 1
	if Input.is_key_pressed(KEY_A):  # Move left
		PLAYER_VELOCITY.x -= 1
	if Input.is_key_pressed(KEY_D):  # Move right
		PLAYER_VELOCITY.x += 1

	# Normalize the velocity vector to ensure consistent movement SPEED in all directions.
	if PLAYER_VELOCITY.length() > 0:
		PLAYER_VELOCITY = PLAYER_VELOCITY.normalized() * SPEED
	
	# Move the sprite based on velocity and frame time.
	position += PLAYER_VELOCITY * delta

func rotate_player():
	# Set the sprite's rotation to the angle
	rotation = get_angle_mouse() + 1.5

func get_angle_mouse():
			# Get the mouse position relative to the game window
	var mouse_pos = get_global_mouse_position()
	
	# Get the position of the sprite
	var sprite_pos = global_position
	
	# Calculate the direction vector pointing from the sprite to the mouse
	var direction = (mouse_pos - sprite_pos).normalized()
	
	# Calculate the angle to rotate
	return direction.angle()

func mouse_click():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not was_pressed:
			shoot_bullet()
			was_pressed = true
	else:
		was_pressed = false
		
func shoot_bullet():
	var bullet = bullet_sprite.instantiate()
	bullet.position = position
	bullet.set_direction(angle_to_vector2(get_angle_mouse()))
	get_tree().current_scene.add_child(bullet)

# Assuming angle is in radians
func angle_to_vector2(angle: float) -> Vector2:
	var x = cos(angle)
	var y = sin(angle)
	return Vector2(x, y)
