extends Control

var main
var moneyProjectFactory
var researchProjectFactory

var project1_complete = false
var project2_complete = false
var project3_complete = false

var projects = []
var index_project_mapping = {}

# var project1 = Project.new(title="", text="",complete=false, money_cost=0, research_cost=0, project_index=0, project_unlocks=0)
# Money projects
var project1 = Project.new("First project", "project description", false, 100, 1, 2)
var project2 = Project.new("Acquire company A", "project description", false, 100, 1, 2)
var project3 = Project.new("Acquire company B", "project description", false, 100, 2, 3)
var project4 = Project.new("Acquire company C", "project description", false, 100, 3, 4)

# research projects
var r_project1 = Project.new("First project", "project description", false, 100, 1, 2)
var r_project2 = Project.new("Acquire company A", "project description", false, 100, 1, 2)
var r_project3 = Project.new("Acquire company B", "project description", false, 100, 2, 3)
var r_project4 = Project.new("Acquire company C", "project description", false, 100, 3, 4)

onready var researchProjectsContainer = get_node("MarginContainer/VBoxContainer/ResearchContainer/ResearchProjects/")
onready var moneyProjectsContainer = get_node("MarginContainer/VBoxContainer/ResearchContainer/MoneyProjects/")

func _generate_project(factory, project, money=true):
	var button_text = ""
	if money:
		button_text = project.title + " ($" + str(project.money_cost) + ")"
	else:
		button_text = project.text + " (" + str(project.research_cost) + " Innovation Points)"
	factory.generateProject(button_text, Vector2(100, 50), project)

func _setup_money_projects():
	moneyProjectFactory = ProjectFactory.new()	
	moneyProjectsContainer.add_child(moneyProjectFactory)
	
	_generate_project(moneyProjectFactory, project1, true)
	_generate_project(moneyProjectFactory, project2, true)
	_generate_project(moneyProjectFactory, project3, true)
	_generate_project(moneyProjectFactory, project4, true)
	
func _setup_research_projects():
	researchProjectFactory = ProjectFactory.new()
	researchProjectsContainer.add_child(researchProjectFactory)
	
	_generate_project(researchProjectFactory, r_project1, false)
	_generate_project(researchProjectFactory, r_project2, false)
	_generate_project(researchProjectFactory, r_project3, false)
	_generate_project(researchProjectFactory, r_project4, false)
	
func _setup_projects():
	_setup_money_projects()
	_setup_research_projects()

func _ready():
	main.update_money(0)
	var _success = get_node("clicker").connect("pressed", self, "_on_a1_click")
	_setup_projects()

func _on_a1_click():
	main.update_money(1)
	_generate_project(moneyProjectFactory, project4, true)

func _do_action(_project):
	pass

func _on_projects_item_selected(index):
	_do_action(index)
	print(index)
