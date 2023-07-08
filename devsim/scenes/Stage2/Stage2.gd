extends Control

const Employee = preload("res://scenes/Stage2/Employee.tscn")

var main

var employees = []
var progress = [0,0,0]
onready var art_progress = $m/v/h/vart/ArtProgress
onready var music_progress = $m/v/h/vmusic/MusicProgress
onready var code_progress = $m/v/h/vcode/CodeProgress
onready var cardContainer = $m/v/CardContainer
onready var timer = Timer.new()

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
	pass # Replace with function body.
	
func _per_second():
	for e in employees:
		e.tick()
		var room = e.get_parent().name
		if room == "CardContainer":
			progress[e.job] += (e.skill * e.happiness) * 0.0001
		elif room == "CoffeeRoom":
			main.update_money(-10)
		elif room == "Training":
			main.update_money(-100)
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
	print(jobi)
	var newbie = Employee.instance()
	newbie.init_job(jobi)
	employees.append(newbie)
	cardContainer.add_card(newbie)

func hire_art():
	hire_employee(0)
func hire_music():
	hire_employee(1)
func hire_code():
	hire_employee(2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
