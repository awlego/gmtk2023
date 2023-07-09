extends Button
class_name ProjectButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var callback_function
var callback_object
var callback_args
var idx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setupButtonParams(text, callback_obj, callback, args, index):
	self.text = text
	callback_object = callback_obj
	callback_function = callback
	callback_args = args
	idx = index

func doButton():	
	if callback_object and callback_function:
		callback_object.callv(callback_function, callback_args)
	
	var count = 0
	for b in self.get_parent().project_list:
		if b == self:
			self.get_parent().project_list.remove(count)
		count += 1
	self.get_parent().remove_child(self)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
