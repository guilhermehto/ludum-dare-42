extends KinematicBody2D
class_name Enemy

onready var Sight : = $Sight as Sight

export var MinWait : = 2.75
export var MaxWait : = 7.5
export var MoveSpeed : = 75.0
export var ChaseSpeed : = 125.0
export var SightSpeed : = 0.75
export var MaxHealth : = 2
export var Damage : = 1

enum States { IDLING, PATROLLING }
enum SightDirection { LEFT, RIGHT, TOP, BOTTOM }

var current_state = States.IDLING

var player_found : = false
var player_min_distance : = 75
var player : Player

var top_left_point : Vector2
var top_right_point : Vector2
var bottom_point : Vector2

var path = [] setget _set_path
var next_path_point : Vector2
var path_min_distance = 5

var health_points : = MaxHealth

signal request_path
signal request_path_to_point

func _ready():
	randomize()
	top_left_point = $PatrolArea/TopLeft.global_position
	top_right_point = $PatrolArea/TopRight.global_position
	bottom_point = $PatrolArea/Bottom.global_position
	_change_state()
	$Timer.wait_time = rand_range(MinWait, MaxWait)
	$Timer.start()


func _physics_process(delta : float) -> void:
	if not player_found:
		match current_state:
			States.IDLING:
					pass
			States.PATROLLING:
				var motion : = Vector2()
				if path.size() == 0 and position.distance_to(next_path_point) <= path_min_distance:
					emit_signal('request_path', self)
					print('got to end')
					return
				elif position.distance_to(next_path_point) < path_min_distance:
					next_path_point = path[0]
					path.remove(0)
				
				motion = (next_path_point - position).normalized()
				move_and_collide(motion * MoveSpeed * delta)
	else:
		var motion : = Vector2()
		emit_signal('request_path_to_point', self, player.position)
		if path.size() == 0 and position.distance_to(next_path_point) <= player_min_distance:
			emit_signal('request_path', self)
			if $AttackTimer.is_stopped():
				player.damage(Damage, global_position)
				$AttackTimer.start()
			
			return
		elif position.distance_to(next_path_point) < player_min_distance:
			next_path_point = path[0]
			path.remove(0)
			
		motion = (next_path_point - position).normalized()
		move_and_collide(motion * ChaseSpeed * delta)

func _on_Area2D_body_entered(player : Player) -> void:
	if player == null:
		return
	player_found = true
	self.player = player
	print('player identified')

func _on_BodySpace_body_entered(player : Player) -> void:
	if player == null:
		return
	player_found = true
	self.player = player
	if $AttackTimer.is_stopped():
		player.damage(Damage, global_position)
		$AttackTimer.start()

func _on_Timer_timeout() -> void:
	$Timer.wait_time = rand_range(MinWait, MaxWait)
	_change_state()
	

func _change_state():
	current_state = _get_new_state()
	match current_state:
		States.PATROLLING:
			emit_signal('request_path', self)
		States.IDLING:
			_get_new_sight_direction()

func _get_new_state():
	var states = States.keys()
	match rand_range(0, states.size()) as int:
		0:
			return States.IDLING
		1:
			Sight.stop()
			return States.PATROLLING

func _get_new_sight_direction():
	Sight.start_sight_movement()

func _set_path(new_value : PoolVector2Array):
	path = new_value
	next_path_point = path[0]
	path.remove(0)

func get_random_position() -> Vector2:
	var x = rand_range(top_left_point.x, top_right_point.x)
	var y = rand_range(top_left_point.y, bottom_point.y)
	print(str(x) + ' ' + str(y))
	return Vector2(x, y)

func damage(value : int, attack_origin : Vector2) -> void:
	health_points -= value
	if health_points <= 0:
		print('died')
		queue_free()
		return
	move_and_collide((global_position - attack_origin).normalized() * 50)
	


func _on_AttackTimer_timeout():
	pass # Replace with function body.



