extends KinematicBody2D
class_name Player

export var MoveSpeed : = 150.0

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta : float) -> void:
	var motion : = Vector2()
	
	if Input.is_action_pressed('ui_left'):
		motion.x = -1
	elif Input.is_action_pressed('ui_right'):
		motion.x = 1
	
	if Input.is_action_pressed('ui_up'):
		motion.y = -1
	elif Input.is_action_pressed('ui_down'):
		motion.y = 1
		
	move_and_collide(motion.normalized() * MoveSpeed * delta)
