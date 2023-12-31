extends Control

var main

onready var main_loop_timer = Timer.new()
onready var newGameProgressBar
onready var resourceAllocation 
onready var gamePortfolio
onready var statusWindow
onready var innovationPointsWindow
onready var numEmployeesWindow
onready var advertisingEffectivenessWindow
onready var employeeHappinessWindow
onready var projectsNode
onready var pieChart

var game_names = {
	"The Ancient Parchments": 0,
	"Realm of Battles": 0,
	"Summons of Responsibility": 0,
	"Murderer's Belief": 0,
	"Major Robbery Vehicle": 0,
	"Last Dream": 0,
	"Deadly Clash": 0,
	"Ultra Plumber Siblings": 0,
	"Ruin": 0,
	"Dwelling Malevolent": 0,
	"Crypt Explorer": 0,
	"Steel Equipment Firm": 0,
	"Fable of Zenda": 0,
	"Semi-Existence": 0,
	"Crimson Deceased Salvation": 0,
	"Murky Spirits": 0,
	"Vast Impact": 0,
	"Frontier Realms": 0,
	"Aura": 0,
	"Demon Might Weep": 0,
	"Deity of Conflict": 0,
	"Quiet Mountain": 0,
	"Empire Souls": 0,
	"Supervise": 0,
	"Lifethriller": 0,
	"Spellcaster": 0,
	"Demonio": 0,
	"Warfield": 0,
	"Wyvern Epoch": 0,
	"Cogs of Combat": 0,
	"Celestial Creation": 0,
	"Two-week Siege": 0,
	"The Remainder of Ours": 0,
	"Undiscovered": 0,
	"Blockcraft": 0,
	"Creature Crossing": 0,
	"The Citizens": 0,
	"Association of Myths": 0,
	"Zenith Tales": 0,
	"Missile Association": 0
}

var rating_dict = {
	"A+": 100,
	"A": 20,
	"A-": 12,
	"B+": 8,
	"B": 4,
	"B-": 2,
	"C": 1,
	"F": 0.5,
}
# var project1 = Project.new(title="", text="",complete=false, money_cost=0, research_cost=0, project_index=0, project_unlocks=0,callback=null)


var valid_ratings = rating_dict.keys()

var num_employees = 1000
var employeeHappiness = 1.00
var game_addictiveness = 1
var advertising_bonus = 0
var innovationPoints = 0
var BASE_EMPLOYEE_HAPPINESS_DECLINE = -.004

var new_game_progess

var marketing_projects_dict = {}
var money_projects_dict = {}
var acquire_projects_dict = {}
var innovation_projects_dict = {}

var marketing_counter = 1
func _update_marketing(value):
	innovationPoints -= 100*marketing_counter # THIS IS VERY HACKY
	marketing_counter += 1
	advertising_bonus += value
	if marketing_projects_dict.has(marketing_counter):
		projectsNode.add_research_project(marketing_projects_dict[marketing_counter])
		
func _company_buyout(company_name):
	main.announce("Congratulations on buyout out " + company_name + "!")
	main.announce("Now there is even less competition.")
	pieChart.data['Your Company'] += pieChart.data[company_name] 
	pieChart.data.erase(company_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	main.money = 100000000
	main.announce("Congratulations on your IPO, you're now worth $100,000,000")
	
	add_child(main_loop_timer)
	main_loop_timer.set_wait_time(1)  # Fire every second
	main_loop_timer.connect("timeout", self, "_on_Timer_timeout")
	main_loop_timer.start()
	
	gamePortfolio = get_node("Game Portfolio")
	projectsNode = get_node("Projects")
	pieChart = get_node("PieChart")
	resourceAllocation = get_node("ResourceAllocation/ResourceAllocation")
	newGameProgressBar = get_node("PanelContainer2/vcode/GameProgress")
	innovationPointsWindow = get_node("PanelContainer/VBoxContainer/InnovationPoints")
	numEmployeesWindow = get_node("PanelContainer/VBoxContainer/NumEmployees")
	advertisingEffectivenessWindow = get_node("PanelContainer/VBoxContainer/AdvertisingEffectiveness")
	employeeHappinessWindow = get_node("PanelContainer/VBoxContainer/EmployeeHappiness")

	_update_status_window()
	
	_create_new_game()
	_create_new_game()
	_create_new_game()
	_create_new_game()
	
	_update_game_development_progress(0)
	_check_research_resources()
		
	marketing_projects_dict = {
		1: Project.new("Billboard Ads", "", false, 0, 100, 2, 3, self, "_update_marketing", [0.1]),
		2: Project.new("Programmatic Ads", "", false, 0, 200, 2, 3, self, "_update_marketing", [0.2]),
		3: Project.new("Data-Driving Ads", "", false, 0, 300, 2, 3, self, "_update_marketing", [0.3]),
		4: Project.new("Social Media Ads", "", false, 0, 400, 2, 3, self, "_update_marketing", [0.5]),
		5: Project.new("Mobile Ads", "", false, 0, 500, 2, 3, self, "_update_marketing", [0.7]),
		6: Project.new("AR & VR Ads", "", false, 0, 600, 2, 3, self, "_update_marketing", [1.0]),
	}
	
	innovation_projects_dict = {
		1: Project.new("Use Lootboxes", "", false, 0, 500, 2, 3, self, "_dummy_callback", []),
		2: Project.new("Setup subscriptions", "", false, 0, 700, 2, 3, self, "_dummy_callback", []),
		3: Project.new("Monetize betas", "", false, 0, 400, 2, 3, self, "_dummy_callback", []),
		4: Project.new("AI Artists", "", false, 0, 1000, 2, 3, self, "_dummy_callback", []),
	}
	
	money_projects_dict = {
		1: Project.new("Repurpose Roombas", "", false, 0, 0, 2, 3, self, "_roombas", []),
	}
	
	acquire_projects_dict = {
		1: Project.new("Acquire Digital Crafts", "", false, 3000000000, 0, 2, 3, self, "_company_buyout", ["Digital Crafts"]),
		2: Project.new("Acquire Pebblestar Games", "", false, 10000000000, 0, 2, 3, self, "_company_buyout", ["Pebblestar Games"]),
		3: Project.new("Acquire Youbiwork", "", false, 100000000000, 0, 2, 3, self, "_company_buyout", ["Youbiwork"]),
		4: Project.new("Acquire Mischievous Hound", "", false, 7000000000000, 0, 2, 3, self, "_company_buyout", ["Mischievous Hound"]),
	}
	
	projectsNode.add_research_project(marketing_projects_dict[1])
	projectsNode.add_money_project(money_projects_dict[1])
	projectsNode.add_money_project(acquire_projects_dict[1])
	for i in innovation_projects_dict:
		projectsNode.add_research_project(innovation_projects_dict[i])


func _roombas():
	for child in main.get_children():
		if child.name == "Roombox":
			main.remove_child(child)
			child.queue_free()
	
func _dummy_callback():
	pass
	
func _update_status_window():
	innovationPointsWindow.text = "Innovation Points: " + str(innovationPoints)
	numEmployeesWindow.text = "Company Size: " + str(num_employees) + " employees"
	advertisingEffectivenessWindow.text = "Advertising bonus: " + str(advertising_bonus*100) + "%"
	employeeHappinessWindow.text = "Employee happiness: " + str(employeeHappiness * 100) + "%"

func _calculate_profit():
	var earnings = gamePortfolio._calculate_total_earnings()
	var expenses = num_employees * (30000+resourceAllocation.points_in_resources[3]*1000)
	return earnings - expenses

func _pick_title(my_dictionary):
	var keys = my_dictionary.keys()
	randomize()
	var random_key = keys[randi() % keys.size()]
	my_dictionary[random_key] += 1
	return str(random_key) + " " + str(my_dictionary[random_key])
	
func _create_new_game():
	var title = _pick_title(game_names)
	var rating = valid_ratings[int(randi() % len(valid_ratings))] # todo weight this when you buy ratings and by employee happiness
	var time_left = int(randi() % 120 * (1+advertising_bonus) * game_addictiveness)
	var earning = "$" + str(rating_dict[rating] * (randi() % 100 * 100000))
	gamePortfolio.create_game({game_title=title, time_left=time_left, rating=rating, earning=earning})
	main.announce("Congratulations on releasing " + title + "!")
	
func _update_game_development_progress(override=0):
#	print("1: ", resourceAllocation)
#	print("2: ", resourceAllocation.points_in_resources)
	var new_game_progress = 0.0001 * resourceAllocation.points_in_resources[0] * num_employees * employeeHappiness
	newGameProgressBar.value += new_game_progress
	
	if override != 0:
		newGameProgressBar.value = override
	
	if newGameProgressBar.value >= 100:
		_create_new_game()
		newGameProgressBar.value = 0

func _update_market_share():
	pass
	
func _update_employee_happiness():
	employeeHappiness += BASE_EMPLOYEE_HAPPINESS_DECLINE + 0.001 * resourceAllocation.points_in_resources[3]
	employeeHappiness = max(0, employeeHappiness)
	employeeHappiness = min(employeeHappiness, 1)
	
func _update_company_size():
	num_employees += resourceAllocation.points_in_resources[1]
	# todo show employee cost to the player
	
func _update_innovation():
	innovationPoints += resourceAllocation.points_in_resources[0] * (float(randi() % 10) / 10)

func _check_research_resources():
	for project in projectsNode.get_active_research_projects():
		if project.innovation_cost > innovationPoints:
			project.disabled = true
		else:
			project.disabled = false
	for project in projectsNode.get_active_money_projects():
		if project.money_cost > main.money:
			project.disabled = true
		else:
			project.disabled = false

func _update_pie_chart():
	pieChart.update_pie_chart()
	
var company2added = false
var company3added = false
var company4added = false
func _check_for_new_projects():
	if main.money > acquire_projects_dict[2].money_cost / 2 and company2added == false:
		projectsNode.add_money_project(acquire_projects_dict[2])
		company2added = true
	if main.money > acquire_projects_dict[3].money_cost / 2 and company3added == false:
		projectsNode.add_money_project(acquire_projects_dict[3])
		company3added = true
	if main.money > acquire_projects_dict[4].money_cost / 2 and company4added == false:
		projectsNode.add_money_project(acquire_projects_dict[4])
		company4added = true

func _update_advertising():
	pass

func _main_loop():
	var profit = _calculate_profit()
	_update_game_development_progress()
	_update_status_window()
	
	_update_market_share()
	_update_employee_happiness()
	_update_company_size()
	_update_innovation()
	_update_advertising()

	_check_research_resources()
	
	_update_pie_chart()
	
	_check_for_new_projects()
	main.update_money(profit)
	
func _on_Timer_timeout():
	_main_loop()
	
func _process(_delta):
	# not sure this actually gets called every frame
	_check_research_resources()
