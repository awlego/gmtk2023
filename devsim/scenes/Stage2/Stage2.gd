extends Control

const Employee = preload("res://scenes/Stage2/Employee.tscn")

var main

var employees = []
var art_progress = 0
var design_progress = 0
var code_progress = 0
var test_progress = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	employees.append_array([Employee.instance(), Employee.instance(), Employee.instance(), Employee.instance()])
	var cardContainer = get_node("m0/CardContainer")
	for i in range(employees.size()):
		employees[i].init_job(i)
		cardContainer.add_child(employees[i])
		employees[i].connect("gui_input", cardContainer, "input")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
