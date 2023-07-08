extends Button
class_name ProjectButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var value
var value2
var value3
var idx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setupButtonParams(text, v, v2, v3, index):
	self.text = text
	value = v
	value2 = v2
	value3 = v3
	idx = index

func doButton():
	var count = 0
	for b in self.get_parent().project_list:
		if b == self:
			self.get_parent().project_list.remove(count)
		count += 1
	self.get_parent().remove_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
