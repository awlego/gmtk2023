extends Panel

class_name Employee
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

const jobs = ["Artist", "Designer", "Coder", "Tester"]
var ename = "get_random_name()Bob"
var happiness = 60
var job = 2
var salary = 20000
var skills = [30, 36, 67, 40]
#var style = StyleBoxFlat.new()

const need_types = ["Success", "Money", "Amenities", "Social"]
var needs = [12, 25, 66, 85]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("m0/v0/Name").text = ename
	get_node("m0/v0/Info/Job").text = _to_string()
	set_constant_size(150, 250)
	mouse_filter = Control.MOUSE_FILTER_STOP
	make_children_ignore_mouse(self)
	# Change background color
	pass # Replace with function body.

func randomize_me():
	ename = get_random_name()
	skills = [rand100(), rand100(), rand100(), rand100()]
	job = skills.find(skills.max())
	salary = randi() % 30000 + 20000
	needs = [rand100(), rand100(), rand100(), rand100()]

func init_job(jobi):
	randomize_me()
	jobi = jobi%4
	var oldj = job
	var oldskill = skills[job]
	skills[job] = skills[jobi]
	skills[jobi] = oldskill
	job = jobi
	
func set_constant_size(width, height):
	rect_min_size = Vector2(width, height)
	#rect_max_size = Vector2(width, height)
	set_size(Vector2(width, height))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _to_string():
	var s = "Happiness: " + str(happiness)
	s += "\nJob: " + jobs[job]
	s += "\nSalary: $" + str(salary)
	s += "\nSkills:"
	s += "\n  Artistry: " + str(skills[0])
	s += "\n  Designing: " + str(skills[1])
	s += "\n  Programming: " + str(skills[2])
	s += "\n  Testing: " + str(skills[3])
	s += "\nNeeds:"
	s += "\n  Success: " + str(needs[0])
	s += "\n  Money: " + str(needs[1])
	s += "\n  Amenities: " + str(needs[2])
	s += "\n  Social: " + str(needs[3])
	return s

func _gui_input(event):
	emit_signal("gui_input", event, self)

func make_children_ignore_mouse(node):
	if node == null:
		pass
	for child in node.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
		make_children_ignore_mouse(child)
