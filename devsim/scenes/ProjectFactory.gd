extends VBoxContainer
class_name ProjectFactory

var project_list = []

func _ready():
	pass # Replace with function body.

func generateProject(input_string, size=Vector2(50,20), callback_obj=null, callback_function=null, callback_args=[], m_cost=0, i_cost=0):
	var new_project = ProjectButton.new()
	new_project.rect_min_size = size
	new_project.setupButtonParams(input_string, callback_obj, callback_function, callback_args, len(project_list), m_cost, i_cost)
	new_project.connect("pressed", new_project, "doButton")
	project_list.append(new_project)
	self.add_child(new_project)

