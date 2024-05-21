extends Area2D

var velocity = Vector2() # Velocity of the bullet
var speed = 500 # Speed of the bullet

func _ready():
	connect('body_entered', Callable(self, '_on_body_entered'))
	pass

func _process(delta):
	# Move the bullet according to its velocity
	position += velocity * delta

func set_direction(direction: Vector2):
	# Set the velocity of the bullet based on the given direction
	velocity = direction.normalized() * speed
	rotate(direction.normalized().angle())


#func _on_body_entered(body):
	#if body.name == "Player":
		#return
	#print(body.name)
	##body.decreawaseHealth()
