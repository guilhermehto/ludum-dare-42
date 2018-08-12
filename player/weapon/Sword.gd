extends Area2D


export var AttackTime : = 0.65
export var Damage : = 1

var is_on_top : = false

var bottom_rotation = -150
var top_rotation = -25

var is_attacking = false

func _ready():
	connect('body_entered', self, '_on_body_entered')
	pass


func _process(delta : float) -> void:
	if Input.is_action_just_pressed('attack') and $Timer.is_stopped():
		is_attacking = true
		$Timer.start()
		$Tween.stop_all()
		if is_on_top:
			$Tween.interpolate_property(self, 'rotation_degrees', rotation_degrees, bottom_rotation, AttackTime, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
			is_on_top = false
		else:
			$Tween.interpolate_property(self, 'rotation_degrees', rotation_degrees, top_rotation, AttackTime, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
			is_on_top = true
		$Tween.start()
	
func _on_body_entered(enemy : Enemy) -> void:
	if enemy == null or not is_attacking:
		return
	enemy.damage(Damage, get_parent().global_position)

func _on_Tween_tween_completed(object, key):
	is_attacking = false
