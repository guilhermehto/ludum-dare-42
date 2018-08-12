extends KinematicBody2D
class_name Player

export var MoveSpeed : = 150.0
export var MaxHealth : = 4

var current_health : int = MaxHealth

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta : float) -> void:
	var motion : = Vector2()
	if Input.is_action_just_pressed('ui_page_up'):
		move_and_collide(Vector2(0, 1) * 50)
	
	if Input.is_action_pressed('ui_left'):
		motion.x = -1
	elif Input.is_action_pressed('ui_right'):
		motion.x = 1
	
	if Input.is_action_pressed('ui_up'):
		motion.y = -1
	elif Input.is_action_pressed('ui_down'):
		motion.y = 1
		
	move_and_collide(motion.normalized() * MoveSpeed * delta)

func damage(value : int, attack_origin : Vector2) -> void:
	print('player damaged')
	current_health -= value
	if current_health <= 0:
		print('died')
	move_and_collide((global_position - attack_origin).normalized() * 50)



