extends Control

var main

var project1_complete = false
var project2_complete = false
var project3_complete = false

var projects = []

var index_project_mapping = {}

func _ready():
	main.update_money(0)
	var _success = get_node("clicker").connect("pressed", self, "_on_a1_click")

	var project1 = Project.new("First project", false, 100, 1, 2)
	var project2 = Project.new("Second project", false, 100, 2, 3)
	# Add items to the ItemList and the corresponding objects to the array
	projects.append(project1)
	projects.append(project2)
	
func _on_a1_click():
	main.update_money(1)
	

func _do_action(_project):
	pass

func _on_projects_item_selected(index):
	_do_action(index)
	print(index)
