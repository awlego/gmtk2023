extends Panel


class_name Employee
const WIDTH = 150
const HEIGHT = 200
const names = [
	"Ethan", "Emma", "Benjamin", "Olivia", "Daniel", "Ava", "William", "Sophia", "Jacob", "Isabella",
	"Samuel", "Mia", "Matthew", "Charlotte", "Alexander", "Amelia", "Henry", "Harper", "Christopher", "Evelyn",
	"Joseph", "Abigail", "James", "Emily", "Andrew", "Elizabeth", "Nicholas", "Sofia", "David", "Grace",
	"Gabriel", "Lily", "Caleb", "Victoria", "Isaac", "Hannah", "Nathan", "Avery", "Liam", "Scarlett",
   # Continue adding more names...
]
func get_random_name():
	return names[randi() % names.size()]
func rand100():
	return randi() % 100

const jobs = ["Artist", "Musician", "Coder"]
const colors = [Color("#996060"), Color("#606099"), Color("#609960")]
var ename = "get_random_name()Bob"
var happiness = 60
var job = 2
var salary = 20000
var skill = 100
#var style = StyleBoxFlat.new()

const need_types = ["Coffee", "Office", "Social"]
var needs = [12, 25, 66]
var need_growth = [10, 10, 10]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("m0/v0/Name").text = ename
	get_node("m0/v0/Info/Job").text = _to_string()
	colorize()
	set_constant_size(WIDTH, HEIGHT)
	mouse_filter = Control.MOUSE_FILTER_STOP
	make_children_ignore_mouse(self)

	# Change background color
	pass # Replace with function body.

func randomize_me():
	ename = get_random_name()
	skill = max(50, rand100())
	job = randi() % jobs.size()
	salary = randi() % 30000 + 20000
	needs = [rand100(), rand100(), rand100()]
	need_growth = [rand100(), rand100(), rand100()]
	update_happiness()
	#get_node("m0/v0/Info/Job").text = _to_string()
	#colorize()

func update_info():
	$m0/v0/Info/Job.text = _to_string()

func update_happiness():
	var sumneeds = 0
	for need in needs:
		sumneeds += need
	happiness = 100 - sumneeds / needs.size()
	
func tick():
	for i in range(needs.size()):
		if rand100() <= need_growth[i]:
			needs[i] += 1
	
	var parent = get_parent().name
	if parent == "CoffeeRoom":
		needs[0] -= 25
	elif parent == "Training":
		if randi() % 100 <= happiness && randi() % 2 == 0:
			skill += 1
			if skill > 110:
				skill = 110
	elif parent == "SocialRoom":
		var bonus = -10
		for i in get_parent().get_children():
			if i.get_class() == self.get_class():
				bonus += 10
		bonus = max(0, bonus)
		needs[2] -= bonus
	
	for i in range(needs.size()):
		if needs[i] < 0:
			needs[i] = 0
		elif needs[i] > 100:
			needs[i] = 100
	
	if skill > 100:
		if randi() % 100 == 0:
			skill -= 1
	update_happiness()
	update_info()

func init_job(jobi):
	randomize_me()
	job = jobi % jobs.size()
	#get_node("m0/v0/Info/Job").text = _to_string()
	#colorize()
	
func colorize():
	var stylebox = get_stylebox("panel").duplicate()
	if stylebox is StyleBoxFlat:
		stylebox.bg_color = colors[job].to_rgba32()
	add_stylebox_override("panel", stylebox)
	#add_color_override("panel/bg_color", Color(1,0,0,1))

func set_constant_size(width, height):
	rect_min_size = Vector2(width, height)
	set_size(Vector2(width, height))

func _to_string():
	var s = "Happiness: " + str(happiness)
	s += "\nJob: " + jobs[job]
	s += "\nSalary: $" + str(salary)
	s += "\nSkill: " + str(skill)
	s += "\nNeeds:"
	s += "\n  Coffee: " + str(needs[0])
	s += "\n  Office: " + str(needs[1])
	s += "\n  Social: " + str(needs[2])
	return s

func _gui_input(event):
	emit_signal("gui_input", event, self)

func make_children_ignore_mouse(node):
	if node == null:
		pass
	for child in node.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
		make_children_ignore_mouse(child)
