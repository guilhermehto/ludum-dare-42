extends Navigation2D

func _ready() -> void:
	for enemy in $Enemies.get_children():
		enemy.connect('request_path', self, '_on_path_requested')


func _on_path_requested(enemy : Enemy) -> void:
	print('path requested')
	var goal_position = enemy.get_random_position()
	var path = get_simple_path(enemy.global_position, goal_position, false)
	enemy.path = path
	for p in path:
		print(p)
	
