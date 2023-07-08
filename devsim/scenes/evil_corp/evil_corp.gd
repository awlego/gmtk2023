extends Control

var main
var moneyProjectFactory
var researchProjectFactory

var project1_complete = false
var project2_complete = false
var project3_complete = false

var projects = []
var index_project_mapping = {}

var project1 = Project.new("First project", "project description", false, 100, 1, 2)
var project2 = Project.new("Second project", "project description", false, 100, 2, 3)

onready var researchProjectsContainer = get_node("MarginContainer/VBoxContainer/ResearchContainer/ResearchProjects/")
onready var moneyProjectsContainer = get_node("MarginContainer/VBoxContainer/ResearchContainer/MoneyProjects/")

func _setup_money_projects():
	moneyProjectFactory = ProjectFactory.new()	
	moneyProjectsContainer.add_child(moneyProjectFactory)

	var button_text = project1.text + " ($" + str(project1.money_cost) + ")"
	moneyProjectFactory.generateProject(button_text, Vector2(100, 50), project1)
	
func _setup_research_projects():
	researchProjectFactory = ProjectFactory.new()
	researchProjectsContainer.add_child(researchProjectFactory)
	
	var button_text = project1.text + " (" + str(project1.research_cost) + " Innovation Points)"
	researchProjectFactory.generateProject(button_text, Vector2(100, 50), project1)
	
	button_text = project1.text + " (" + str(project1.research_cost) + " Innovation Points)"
	researchProjectFactory.generateProject(button_text, Vector2(100, 50))
	
func _setup_projects():
	_setup_money_projects()
	_setup_research_projects()

func _ready():
	main.update_money(0)
	var _success = get_node("clicker").connect("pressed", self, "_on_a1_click")
	_setup_projects()

func _on_a1_click():
	main.update_money(1)

func _do_action(_project):
	pass

func _on_projects_item_selected(index):
	_do_action(index)
	print(index)
