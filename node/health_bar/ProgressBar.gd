extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	value = 100
	pass # Replace with function body.


func decreaseHealth():
	value += -1
