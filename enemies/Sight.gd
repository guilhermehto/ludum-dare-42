extends Area2D
class_name Sight

onready var TweenNode = $Tween as Tween

enum SightDirection { LEFT, RIGHT, TOP, BOTTOM }

var looking_at = SightDirection.BOTTOM
var current_target = 0

func _ready():
	randomize()


func stop() -> void:
	TweenNode.stop_all()

func start_sight_movement() -> void:
	TweenNode.stop_all()
	current_target = rand_range(-360, 360)
	TweenNode.interpolate_property(self, 'rotation_degrees', rotation_degrees, current_target, 3.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()


func _on_Tween_tween_completed(object, key):
	start_sight_movement()

