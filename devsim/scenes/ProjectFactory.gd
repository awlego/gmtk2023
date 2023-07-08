extends VBoxContainer
class_name ProjectFactory

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var project_list = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generateProject(input_string):
	#print(input_string)
	var new_project = ProjectButton.new()
	#print(len(project_list))
	new_project.setupButtonParams(input_string, 1, 2, 3, len(project_list))
	#new_project.pressed.connect(new_project.doButton)
	#new_project.pressed(funcref(new_project, "doButton"))
	#button.connect("pressed", self, "_on_Button_pressed")
	new_project.connect("pressed", new_project, "doButton")
	project_list.append(new_project)
	self.add_child(new_project)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
