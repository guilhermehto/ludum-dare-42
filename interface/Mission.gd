extends HBoxContainer
class_name Mission


var title : String
var description : String
var price : int


func init(title : String, description : String, price : int) -> void:
	self.title = title
	self.description = description
	self.price = price
	$VBoxContainer/Title.text = title
	$VBoxContainer/Label.text = description