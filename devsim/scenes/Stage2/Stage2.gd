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
	for e in employees:
		e.tick()
		var room = e.get_parent().name
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
	
	#controlling animations based on room dictionary.
	if occupants["CoffeeRoom"] > 0:
		$Animations/CoffeeSprite1.show()
		$Animations/CoffeeSprite2.show()
		$Animations/CoffeeSprite3.show()
		$Animations/CoffeeSprite1/AnimationPlayer1.play("InCoffeeRoom")
	else:
		$Animations/CoffeeSprite1.hide()
		$Animations/CoffeeSprite2.hide()
		$Animations/CoffeeSprite3.hide()
	if occupants["Training"] > 0:
		$Animations/AnimatedSprite.show()
		$Animations/AnimatedSprite.play("flip")
	else:
		$Animations/AnimatedSprite.hide()
	if occupants["SocialRoom"]:
		$Animations/WordBubble1.show()
		$Animations/WordBubble2.show()
		$Animations/WordBubble3.show()
		$Animations/WordBubble3/AnimationPlayer.play("BreakRoomWords")
	else:
		$Animations/WordBubble1.hide()
		$Animations/WordBubble2.hide()
		$Animations/WordBubble3.hide()
	
		
	print(occupants)
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
	var button = Button.new()
	var on_descendant = cardContainer.get_node("v/h2/FIRE")
	var offset = Vector2(-30, 20)
	button.text = "Renovate the office"
	button.rect_position = get_relative_pos_topleft(on_descendant) + offset
	button.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	button.connect("pressed", self, "renovate")
	var fr = FuncRef.new()
	fr.set_instance(self)
	fr.set_function("get_relative_reno")
	popups[button] = [fr, [on_descendant, button], offset]
	add_child(button)
	return button
	
func cleanup_popup(popup):
	popups.erase(popup)

func renovate():
	main.update_money(-1000 * employees.size())
	for e in employees:
		e.needs[1] = 0
		e.update_info()
		
var dollars_coffee = 0
func pay_for_coffee(dollars):
	dollars_coffee += dollars
	main.update_money(0-dollars)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
