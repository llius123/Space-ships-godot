extends CharacterBody2D

var enemy_node

var follow_area = false

func _ready():
	$FocusArea.connect('body_entered', Callable(self, 'enemy_entered'))
	$FocusArea.connect('body_exited', Callable(self, 'enemy_exit'))
	$BodyArea.connect('area_entered', Callable(self, 'bullet_entered'))
	$FollowArea.connect('body_entered', Callable(self, 'follow_area_entered'))

func _process(delta):
	if enemy_node == null:
		return
	rotate_enemy();
	follow_player();


func enemy_entered(node):
	enemy_node = node

func enemy_exit(node):
	enemy_node = null

func bullet_entered(node):
	$HealthBar/ProgressBar.decreaseHealth()

func rotate_enemy():
	var direction = (enemy_node.position - position).normalized()
	rotation = direction.angle() + 1.5

func follow_area_entered(node):
	follow_area = true

func follow_area_exited():
	follow_area = false

func follow_player():
	if !follow_area:
		return;
	var node = Utils.get_node_by_name("PLAYER")
	position = node.position
	print(node.position)
	#get_all_nodes(get_tree().root)
	
func get_all_nodes(node: Node) -> Array:
	var all_nodes = []
	for child in node.get_children():
		all_nodes.append(child)
		all_nodes += get_all_nodes(child)
	return all_nodes
