extends Control

const Employee = preload("res://scenes/Stage2/Employee.tscn")
const GrimButton = preload("res://GrimButton.gd")

var main

var popups = {}
var employees = []
var progress = [0,0,0]
onready var art_progress = $m/v/h/vart/ArtProgress
onready var music_progress = $m/v/h/vmusic/MusicProgress
onready var code_progress = $m/v/h/vcode/CodeProgress
onready var cardContainer = $m/v/CardContainer
onready var timer = Timer.new()
var occupants = {"CardContainer": 0, "CoffeeRoom": 0, "Training": 0, "SocialRoom": 0}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	cardContainer.stage = self
	for i in range(3):
		hire_employee(i)
	
	timer.wait_time = 1.0
	timer.one_shot = false
	add_child(timer)
	timer.connect("timeout", self, "_per_second")
	timer.start()
	
	$m/v/h/vart/HireArt.connect("pressed", self, "hire_art")
	$m/v/h/vmusic/HireMusic.connect("pressed", self, "hire_music")
	$m/v/h/vcode/HireCode.connect("pressed", self, "hire_code")
	popup_grim_button(cardContainer.get_node("v/h/CoffeeRoom"), Vector2(50, 50), "HELLO", self, "hire_code")
	create_renovate_button()
	
func _process(delta):
	for popup in popups.keys():
		var arr = popups[popup]
		var fnc = arr[0]
		
		popup.rect_position = fnc.call_funcv(arr[1]) + arr[2]
		#print(popup)
	
func _per_second():
	occupants = {"CardContainer": 0, "CoffeeRoom": 0, "Training": 0, "SocialRoom": 0}
	var cjs = coffee_jockeys
	for e in employees:
		var room = e.get_parent().name
		if cjs > 0 && room != "CoffeeRoom" && e.needs[0] > 0:
			cjs -= 1
			e.needs[0] -= 1
			pay_for_coffee(20)
		e.tick()
		if room == "CardContainer":
			progress[e.job] += (e.skill * e.happiness) * 0.0001
			occupants["CardContainer"] += 1
		elif room == "CoffeeRoom":
			pay_for_coffee(10)
			occupants["CoffeeRoom"] += 1
		elif room == "Training":
			main.update_money(-100)
			occupants["Training"] += 1
		elif room == "SocialRoom":
			occupants["SocialRoom"] += 1
		main.update_money(-1 * e.salary / 365)
		
	if progress.min() >= 100:
		main.update_money(100000)
		progress = [0,0,0]
	
	art_progress.value = progress[0]
	music_progress.value = progress[1]
	code_progress.value = progress[2]

func fire_employee(c):
	employees.remove(employees.find(c))
	c.queue_free()

func hire_employee(jobi):
	var newbie = Employee.instance()
	newbie.init_job(jobi)
	employees.append(newbie)
	cardContainer.add_card(newbie)
	main.update_money(-1000)

func hire_art():
	hire_employee(0)
func hire_music():
	hire_employee(1)
func hire_code():
	hire_employee(2)

func get_relative_pos_topleft(descendant):
	var stage_pos = get_global_rect().position
	var desc_pos = descendant.get_global_rect().position
	return desc_pos - stage_pos

func get_relative_reno(d, rb):
	return get_relative_pos_topleft(d) - Vector2(rb.rect_size.x, 0)

func get_relative_pos_topright(descendant):
	return get_relative_pos_topleft(descendant) + Vector2(descendant.rect_size.x, 0)

func create_button(button, fr, frargs, offset, text, target_node, target_func):
	button.connect("pressed", target_node, target_func)
	button.text = text
	button.rect_position = fr.call_funcv(frargs) + offset
	popups[button] = [fr, frargs, offset]
	add_child(button)
	return button

func popup_grim_button(on_descendant, pos_on_desc, text, target_node, target_func):
	var button = GrimButton.new()
	button.connect("pressed", target_node, target_func)
	button.connect("cleanup", self, "cleanup_popup")
	button.text = text
	button.rect_position = get_relative_pos_topleft(on_descendant) + pos_on_desc
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_pos_topleft")
	popups[button]= [fr, [on_descendant], pos_on_desc]
	add_child(button)
	return button

func create_renovate_button():
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_reno")
	var button = Button.new()
	return create_button(button, fr, [cardContainer.get_node("v/h2/FIRE"), button], Vector2(-30,20), "Renovate the office", self, "renovate")
	
func cleanup_popup(popup):
	popups.erase(popup)

func renovate():
	main.update_money(-1000 * employees.size())
	for e in employees:
		e.needs[1] = 0
		e.update_info()

# COFFEE!!
var dollars_coffee = 0
var coffee_jockey_unlock = false
const COFFEE_JOCKEY_UNLOCK = 2000
var coffee_jockeys = 0

func pay_for_coffee(dollars):
	dollars_coffee += dollars
	main.update_money(0-dollars)
	if !coffee_jockey_unlock && dollars_coffee >= COFFEE_JOCKEY_UNLOCK:
		var cj = Button.new()
		var fr0 = FuncRef.new()
		fr0.set_instance(self)
		fr0.set_function("get_relative_pos_topleft")
		create_button(cj, fr0, [cardContainer.get_node("v/h/CoffeeRoom")], Vector2(20, 30), "Hire Coffee Jockey", self, "hire_coffee_jockey")
		

func hire_coffee_jockey():
	pass
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
