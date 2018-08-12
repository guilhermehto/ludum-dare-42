extends HBoxContainer
class_name Mission

export var MinPrice : int = 2500
export var MaxPrice : int = 7500

var title : String
var description : String
var price : int

var hairs = [
	preload('res://interface/portraits/hair-a.png'),
	preload('res://interface/portraits/hair-b.png'),
	preload('res://interface/portraits/hair-c.png'),
	preload('res://interface/portraits/hair-d.png'),
	preload('res://interface/portraits/hair-e.png'),
]
var clothes = [
	preload('res://interface/portraits/clothes-a.png'),
	preload('res://interface/portraits/clothes-b.png'),
	preload('res://interface/portraits/clothes-c.png'),
	preload('res://interface/portraits/clothes-d.png'),
	preload('res://interface/portraits/clothes-e.png'),
	preload('res://interface/portraits/clothes-f.png'),
	preload('res://interface/portraits/clothes-g.png'),
]
var features = [
	preload('res://interface/portraits/feature-a.png'),
	preload('res://interface/portraits/feature-b.png'),
	preload('res://interface/portraits/feature-c.png'),
	preload('res://interface/portraits/feature-d.png'),
]

func ready() -> void:
	randomize()

func init(title : String, description : String, price : int) -> void:
	self.title = title
	self.description = description
	self.price = rand_range(MinPrice, MaxPrice)
	$VBoxContainer/Title.text = title
	$VBoxContainer/Label.text = description
	$StartMission/Label.text = '$' + str(self.price)
	_generate_portrait()


func _generate_portrait() -> void:
	$Potrait/Clothes.texture = clothes[rand_range(0, clothes.size())]
	if rand_range(0, 100) > 80:
		$Potrait/Feature.texture = features[rand_range(0, features.size())]
	if rand_range(0, 100) > 10:
		$Potrait/Hair.texture = hairs[rand_range(0, hairs.size())]
	