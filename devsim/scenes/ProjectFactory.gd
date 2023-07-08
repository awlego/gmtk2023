extends VBoxContainer
class_name ProjectFactory

var project_list = []

func _ready():
	pass # Replace with function body.

func generateProject(input_string, size=Vector2(50,20), param1=1):
	var new_project = ProjectButton.new()
	new_project.rect_min_size = size
	new_project.setupButtonParams(input_string, param1, 2, 3, len(project_list))
	new_project.connect("pressed", new_project, "doButton")
	project_list.append(new_project)
	self.add_child(new_project)

