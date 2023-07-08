extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rect_min_size.y = 20
	rect_size.y = 20
	rect_min_size.x = Employee.WIDTH -10
	rect_size.x = Employee.WIDTH -10
	align = Label.ALIGN_CENTER
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
