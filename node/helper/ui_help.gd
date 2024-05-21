extends Control

var enemy_sprite = preload("res://node/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", Callable(self, "_on_button_pressed"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var enemy = enemy_sprite.instantiate()
	var center_position = get_viewport_rect().size * 0.5
	enemy.position = center_position
	get_tree().current_scene.add_child(enemy)
