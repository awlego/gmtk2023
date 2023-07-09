extends Control

const Employee = preload("res://scenes/Stage2/Employee.tscn")
const GrimButton = preload("res://GrimButton.gd")
const EnjoyTimer = preload("res://scenes/EnjoyTimer.gd")
const Roomba = preload("res://scenes/Stage2/Roomba.gd")

var main

var popups = {}
var employees = []
var progress = [0,0,0]
onready var art_progress = $m/v/h/vart/ArtProgress
onready var music_progress = $m/v/h/vmusic/MusicProgress
onready var code_progress = $m/v/h/vcode/CodeProgress
onready var cardContainer = $m/v/CardContainer
onready var coffeeRoom = cardContainer.get_node("v/h/CoffeeRoom")
onready var training = cardContainer.get_node("v/h/Training")
onready var socialRoom = cardContainer.get_node("v/h/SocialRoom")
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
	popup_grim_button(coffeeRoom, Vector2(50, 50), "HELLO", self, "hire_code")
	create_renovate_button()
	
func _process(_delta):
	for popup in popups.keys():
		var arr = popups[popup]
		var fnc = arr[0]
		
		popup.rect_position = fnc.call_funcv(arr[1]) + arr[2]
		#print(popup)
	
func _per_second():
	occupants = {"CardContainer": 0, "CoffeeRoom": 0, "Training": 0, "SocialRoom": 0}
	var cjs = coffee_jockeys
	var roos = roomba
	var randaccess = range(employees.size())
	var totalskill = 0
	for _i in range(employees.size()):
		var ii = randi() % randaccess.size()
		var e = employees[randaccess[ii]]
		randaccess.remove(ii)
		var room = e.get_parent().name
		e.tick()
		totalskill += e.skill
		if (cjs > 0) && (room != "CoffeeRoom") && (e.needs[0] > 0):
			cjs -= 1
			e.needs[0] -= 1
			pay_for_coffee(20)
		if (roos > 0) && (e.needs[1] > 0):
			roos -= 1
			e.needs[1] -= 1
		if slack_pro:
			e.needs[2] -= 1
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
	
	if !(slack_pro_toggle) && main.hours_enjoyed > SLACK_UNLOCK:
		create_slack_toggle()
	
	if slack_pro:
		main.update_money(-25 * employees.size())
	
	#controlling animations based on room dictionary.
	if occupants["CoffeeRoom"] > 0:
		coffeeRoom.get_node("CoffeeSprite1").show()
		coffeeRoom.get_node("CoffeeSprite2").show()
		coffeeRoom.get_node("CoffeeSprite3").show()
		coffeeRoom.get_node("CoffeeSprite1/AnimationPlayer1").play("InCoffeeRoom")
	else:
		coffeeRoom.get_node("CoffeeSprite1").hide()
		coffeeRoom.get_node("CoffeeSprite2").hide()
		coffeeRoom.get_node("CoffeeSprite3").hide()
	var tsprite = training.get_node("AnimatedSprite")
	if occupants["Training"] > 0:
		tsprite.show()
		tsprite.position = (training.rect_size - Vector2(0,0)) / 2
		tsprite.play("flip")
	else:
		tsprite.hide()
	if occupants["SocialRoom"]:
		socialRoom.get_node("WordBubble1").show()
		socialRoom.get_node("WordBubble2").show()
		socialRoom.get_node("WordBubble3").show()
		socialRoom.get_node("WordBubble3/AnimationPlayer").play("BreakRoomWords")
	else:
		socialRoom.get_node("WordBubble1").hide()
		socialRoom.get_node("WordBubble2").hide()
		socialRoom.get_node("WordBubble3").hide()
		
	if progress.min() >= 100:
		var multi = max(1000, totalskill) / 1000.0
		main.update_money(int((120000 + randi() % 40000) * multi))
		add_child(EnjoyTimer.new(int((240000 + randi() % 40000) * multi), main))
		progress = [0,0,0]
	
	if main.money > IPO_SHOW && !(ipo_btn):
		create_ipo_btn()
	if main.money > IPO_ENABLE && ipo_btn:
		ipo_btn.disabled = false
	
#	main.money += 1000000
#	print("ADDING MONEY")
	art_progress.value = progress[0]
	music_progress.value = progress[1]
	code_progress.value = progress[2]

func fire_employee(c):
	employees.remove(employees.find(c))
	c.queue_free()
	if renovate_btn:
		update_renovate_btn()

func hire_employee(jobi):
	if main.money < 0 && employees.size() > 10:
		return
	var newbie = Employee.instance()
	newbie.init_job(jobi)
	employees.append(newbie)
	cardContainer.add_card(newbie)
	main.update_money(-1000)
	if renovate_btn:
		update_renovate_btn()

func hire_art():
	hire_employee(0)
func hire_music():
	hire_employee(1)
func hire_code():
	hire_employee(2)

func get_relative_pos_botleft(descendant):
	return get_relative_pos_topleft(descendant) + Vector2(0, descendant.rect_size.y)

func get_relative_pos_topleft(descendant):
	var stage_pos = get_global_rect().position
	var desc_pos = descendant.get_global_rect().position
	return desc_pos - stage_pos

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
	
func cleanup_popup(popup):
	popups.erase(popup)

# Renovations
var renovate_btn
var dollars_reno = 0
var roomba_unlock = false
const ROOMBA_UNLOCK = 100000
var has_renovated = false
var roomba = 0
var roomba_btn
var roomba_cost = 10000

func create_renovate_button():
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_reno")
	renovate_btn = Button.new()
	return create_button(renovate_btn, fr, [cardContainer.get_node("v/h2/FIRE"), renovate_btn], Vector2(-30,20), "Renovate the office $3000", self, "renovate")

func get_relative_reno(d, rb):
	return get_relative_pos_topleft(d) - Vector2(rb.rect_size.x, 0)

func update_renovate_btn():
	var msg = "Renovate the office $"
	if has_renovated:
		msg = "Renovate $"
	renovate_btn.text = msg + str(1000 * employees.size())

func renovate():
	main.update_money(-1000 * employees.size())
	has_renovated = true
	dollars_reno += 1000 * employees.size()
	for e in employees:
		e.needs[1] = 0
		e.update_info()
	if !roomba_unlock && (dollars_reno > ROOMBA_UNLOCK):
		roomba_unlock = true
		create_roomba_btn()
	update_renovate_btn()

func create_roomba_btn():
	roomba_btn = Button.new()
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_pos_botleft")
	create_button(roomba_btn, fr, [renovate_btn], Vector2(0, 5), "Roomba?", self, "buy_roomba")
	roomba_btn.rect_size = renovate_btn.rect_size
	var roombox = Node.new()
	roombox.name = "Roombox"
	main.add_child(roombox)

func buy_roomba():
	roomba += 1
	main.update_money(0-roomba_cost)
	roomba_cost = int(roomba_cost * 1.1)
	main.get_node("Roombox").add_child(Roomba.new())
	update_roomba_btn()

func update_roomba_btn():
	roomba_btn.text = "Roombas (" + str(roomba) + ") $" + str(roomba_cost)


# COFFEE!!
var dollars_coffee = 0
var coffee_jockey_unlock = false
const COFFEE_JOCKEY_UNLOCK = 2000
var coffee_jockeys = 0
var cj_cost = 1000
var cj_button

func pay_for_coffee(dollars):
	dollars_coffee += dollars
	main.update_money(0-dollars)
	if !coffee_jockey_unlock && dollars_coffee >= COFFEE_JOCKEY_UNLOCK:
		cj_button = Button.new()
		var fr0 = FuncRef.new()
		fr0.set_instance(self)
		fr0.set_function("get_relative_pos_topleft")
		create_button(cj_button, fr0, [cardContainer.get_node("v/h/CoffeeRoom")], Vector2(20, 30), "Hire Coffee Jockey $" + str(cj_cost), self, "hire_coffee_jockey")
		coffee_jockey_unlock = true

func hire_coffee_jockey():
	coffee_jockeys += 1
	main.update_money(0 - cj_cost)
	cj_cost = min(1000000, int(cj_cost * 1.08))
	cj_button.text = "Coffee Jockey (" + str(coffee_jockeys) + "): $" + str(cj_cost)


# Company Slack
const SLACK_UNLOCK = 2*1000*1000
var slack_pro_toggle
var slack_pro = false

func create_slack_toggle():
	slack_pro_toggle = CheckButton.new()
	slack_pro_toggle.toggle_mode = true
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_pos_topleft")
	create_button(slack_pro_toggle, fr, [cardContainer.get_node("v/h/SocialRoom")], Vector2(20, 20), "Slack Pro", self, "toggle_slack")
	
func toggle_slack():
	slack_pro = slack_pro_toggle.pressed
	#slack_pro_toggle.toggle_mode = slack_pro


# IPO
const IPO_SHOW = 1000 * 1000
const IPO_ENABLE = 10 * IPO_SHOW
var ipo_btn

func create_ipo_btn():
	ipo_btn = Button.new()
#	ipo_btn.text = "IPO ($10M)"
#	ipo_btn.connect("pressed", self, "ipo")
#	ipo_btn.rect_position = Vector2(20, 0)
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_pos_topleft")
	ipo_btn.disabled = true
#	add_child(ipo_btn)
	create_button(ipo_btn, fr, [cardContainer], Vector2(20, 20), "IPO ($10M)", self, "ipo")

func ipo():
	main.set_stage(main.stage3)
