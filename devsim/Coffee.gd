extends Button

var coffee = 0
var energy
var energy_meter

# Called when the node enters the scene tree for the first time.
func _ready():
	energy = get_node("../energy")
	energy_meter = ProgressBar.new()
	energy_meter.rect_global_position.x = 100
	energy_meter.rect_global_position.y = 100
	get_parent().add_child(energy_meter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coffee_pressed():
	if (coffee == 0): #or (energy_meter.value == 0):
		energy_meter.value = 100
		print("energy " + str(energy_meter.value))
	coffee += 1
	print(coffee * 50)
	print(coffee)
	#energy = get_node(../energy)
	energy.text = "Energy " + str(coffee)
	
	#var newButton = Button.new()
	#newButton.text = "New Button"
	# Set other properties of the button as desired

	# Add the button to the scene hierarchy
	#get_parent().add_child(newButton)

	# Connect the button's pressed signal to a function
	#newButton.connect("pressed", self, "_on_NewButton_pressed")

func _on_Timer_timeout():
	_on_Coffee_pressed()
	
	
	#self._on_Coffee_pressed() # Replace with function body.



