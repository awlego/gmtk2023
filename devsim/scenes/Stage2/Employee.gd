extends Panel

class_name Employee

signal my_gui_input
const WIDTH = 150
const HEIGHT = 200
const names = [
	"Ethan", "Emma", "Benjamin", "Olivia", "Daniel", "Ava", "William", "Sophia", "Jacob", "Isabella",
	"Samuel", "Mia", "Matthew", "Charlotte", "Alexander", "Amelia", "Henry", "Harper", "Christopher", "Evelyn",
	"Joseph", "Abigail", "James", "Emily", "Andrew", "Elizabeth", "Nicholas", "Sofia", "David", "Grace",
	"Gabriel", "Lily", "Caleb", "Victoria", "Isaac", "Hannah", "Nathan", "Avery", "Liam", "Scarlett",
   # Continue adding more names...
]
const phrases = [
	"$player_name$ thinks 'delegating' means 'avoiding work'.",
	"$player_name$'s management style is 'confuse and conquer'.",
	"$player_name$'s decision-making process involves a magic 8-ball.",
	"$player_name$'s coffee addiction is their only reliable source of energy.",
	"$player_name$'s management technique involves excessive 'whistling'.",
	"$player_name$'s office plants are better taken care of than the employees.","$player_name$ thinks Ctrl+Z works in real life too.",
	"We call $player_name$ the 'Bug Generator' because every time they touch the code, new bugs appear.",
	"$player_name$'s coding skills are like a game with permadeath – one wrong move and everything crashes.",
	"$player_name$ once asked us to implement a 'Ctrl+Alt+Del' feature in our game. We had to explain it doesn't work that way.",
	"$player_name$ loves deadlines so much that they once said, 'The game is due yesterday.'",
	"$player_name$'s favorite motivational quote is, 'Code first, ask questions later... or never.'",
	"$player_name$'s favorite game genre is 'Microtransactions: The Simulator.'",
	"$player_name$ always says, 'There's no such thing as a 'small' change. Let's rewrite the entire codebase.'",
	"$player_name$ believes in the power of 'just one more feature'... until it becomes a never-ending list.",
	"When we suggest using an engine for our game, $player_name$ says, 'Why use an engine when you have a steam-powered PC?'",
	"$player_name$'s code is so optimized, it runs at the speed of dial-up internet.",
	"$player_name$ once tried to motivate us by saying, 'Remember, bugs are just undocumented features!'",
	"$player_name$ insists that the best way to test a game is by asking their grandma to play it. She doesn't even know what a joystick is.",
	"$player_name$ believes 'compiling' means printing out the code and stapling it together.",
	"$player_name$ once said, 'Debugging is for weaklings. Real programmers ship it and let the users find the bugs.'",
	"When we complain about crunch time, $player_name$ says, 'But look at all the overtime pay you're not getting!'",
	"$player_name$ has a special talent for breaking things that were already working perfectly fine.",
	"$player_name$ thinks 'pixel art' refers to art made by an artist named Pixel.",
	"$player_name$'s coding style is like a mad scientist's handwriting – impossible to decipher.",
	"When we asked for better hardware, $player_name$ said, 'Just overclock your brains.'",
	"$player_name$ once said, 'We don't need playtesting. The game is perfectly balanced... said no one ever.'",
	"$player_name$'s favorite coding comment is '// TODO: I'll fix this later. Maybe.'",
	"$player_name$'s idea of version control is renaming files with 'v1', 'v2', 'v3'...",
	"$player_name$ once said, 'The key to success in game development is Ctrl+C, Ctrl+V, and a lot of coffee.'",
	"$player_name$ loves spaghetti... code, that is.",
	"When we suggest adding multiplayer to our game, $player_name$ says, 'Just add more players. Problem solved!'",
	"We need to optimize the rendering pipeline.",
	"Let's schedule a playtest session for next week.",
	"The level design needs some adjustments for better player flow.",
	"We should consider adding more particle effects to enhance visuals.",
	"It's time to start working on the multiplayer integration.",
	"The UI needs a redesign to improve user experience.",
	"We have a tight deadline, so let's prioritize bug fixing.",
	"We should implement a save/load system for player progress.",
	"The sound effects for weapon fire need to be more impactful.",
	"Let's brainstorm ideas for new enemy types and behaviors.",
	"We need to localize the game for international markets.",
	"The animation transitions are not smooth enough; let's polish them.",
	"We should add a tutorial to help new players understand the game mechanics.",
	"Let's create a roadmap for future updates and DLC content.",
	"The boss battle needs to be more challenging; let's increase its difficulty.",
	"We should improve the loading times for better player engagement.",
	"The game's performance on low-end devices needs optimization.",
	"We should hire a concept artist to create more visually appealing assets.",
	"Let's organize a team-building event to boost morale.",
	"We need to improve the game's accessibility options for players with disabilities."
]

func comment(player_name="Boss", company_name="this company"):
	var phrase = phrases[randi() % phrases.size()]
	phrase = phrase.replace("$player_name$", player_name)
	phrase = phrase.replace("$company_name$", company_name)
	return ename + ": " + phrase
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
	need_growth = [min(90, rand100()), min(90, rand100()), min(90, rand100())]
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
	emit_signal("my_gui_input", event, self)

func make_children_ignore_mouse(node):
	if node == null:
		pass
	for child in node.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
		make_children_ignore_mouse(child)
