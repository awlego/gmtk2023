extends MarginContainer

var moneyProjectFactory
var researchProjectFactory

var project1_complete = false
var project2_complete = false
var project3_complete = false

var projects = []
var index_project_mapping = {}

# var project1 = Project.new(title="", text="",complete=false, money_cost=0, research_cost=0, project_index=0, project_unlocks=0,callback=null)
# Money projects
var project1 = Project.new("Use billboards", "project description", false, 100, 1, 2)
var project2 = Project.new("Acquire company A", "project description", false, 100, 1, 2)
var project3 = Project.new("Acquire company B", "project description", false, 100, 2, 3)
var project4 = Project.new("Acquire company C", "project description", false, 100, 3, 4)

# research projects
#var r_project1 = Project.new("Use billboards", research_cost=100, project_index=2)
var r_project2 = Project.new("Acquire company A", "project description", false, 0, 1, 2)
var r_project3 = Project.new("Acquire company B", "project description", false, 0, 2, 3)
var r_project4 = Project.new("Acquire company C", "project description", false, 0, 3, 4)

onready var researchProjectsContainer = get_node("PanelContainer/VBoxContainer/ResearchContainer/ResearchProjects")
onready var moneyProjectsContainer = get_node("PanelContainer/VBoxContainer/ResearchContainer/MoneyProjects")

func _generate_project(factory, project, money=true, callback_obj=null, callback=null, callback_args=[]):
	var button_text = ""
	if money:
		button_text = project.title + " ($" + str(project.money_cost) + ")"
	else:
		button_text = project.title + " (" + str(project.research_cost) + " Innovation Points)"
	factory.generateProject(button_text, Vector2(100, 50), callback_obj, callback, callback_args, project.money_cost, project.research_cost)

func _setup_money_projects():
	moneyProjectFactory = ProjectFactory.new()
	moneyProjectsContainer.add_child(moneyProjectFactory)
	
#	_generate_project(moneyProjectFactory, project1, true)
#	_generate_project(moneyProjectFactory, project2, true)
#	_generate_project(moneyProjectFactory, project3, true)
#	_generate_project(moneyProjectFactory, project4, true)
	
func _setup_research_projects():
	researchProjectFactory = ProjectFactory.new()
	researchProjectsContainer.add_child(researchProjectFactory)
	
#	_generate_project(researchProjectFactory, r_project1, false)
#	_generate_project(researchProjectFactory, r_project2, false)
#	_generate_project(researchProjectFactory, r_project3, false)
#	_generate_project(researchProjectFactory, r_project4, false)

func get_active_research_projects():
	return researchProjectFactory.get_children()
	
func get_active_money_projects():
	return moneyProjectFactory.get_children()

func add_research_project(project):
	_generate_project(researchProjectFactory, project, false, project.callback_obj, project.callback, project.callback_args)
	
func add_money_project(project):
	_generate_project(moneyProjectFactory, project, true, project.callback_obj, project.callback, project.callback_args)
	
	
func _setup_projects():
	_setup_money_projects()
	_setup_research_projects()

func _ready():
	_setup_projects()
