extends Button
class_name ProjectButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var callback_function
var callback_object
var value3
var idx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setupButtonParams(text, callback_obj, callback, v3, index):
	self.text = text
	callback_object = callback_obj
	callback_function = callback
	value3 = v3
	idx = index

func doButton():	
	if callback_object and callback_function:
		callback_object.call(callback_function)
	
	var count = 0
	for b in self.get_parent().project_list:
		if b == self:
			self.get_parent().project_list.remove(count)
		count += 1
	self.get_parent().remove_child(self)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
