extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var energy_meter
var computer_boot_flag = 0
var removed = false
onready var removable = get_node("$VSplitContainer/HSplitContainer2/HelloWorld")
var pf

var main
var first_sleep_appear = false
var sleeping = true
var programming_skill = 0

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$VSplitContainer/GameProgress/GameCompletion2.hide()
	$VSplitContainer/GameProgress/Percent.hide()
	$VSplitContainer/HSplitContainer/EnergyMeter.hide()
	$VSplitContainer/HSplitContainer/Label.hide()
	$VSplitContainer/DrinkCoffee.hide()
	$VSplitContainer/BootComputer.hide()
	$VSplitContainer/HSplitContainer2/Label.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.max_length = 20
	pf = ProjectFactory.new()
	self.add_child(pf)
	$VSplitContainer/HBoxContainer2/Art.hide()
	$VSplitContainer/HBoxContainer2/Music.hide()
	$VSplitContainer/HBoxContainer2/Code.hide()
	$VSplitContainer/HBoxContainer/Sleep.hide()
	$VSplitContainer/HBoxContainer/Eat.hide()
	$VSplitContainer/HBoxContainer/Study.hide()
	$VSplitContainer/HBoxContainer/Socialize.hide()
	sleeping = false

	#$HSplitContainer/EnergyMeter.value = 100
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	$VSplitContainer/HSplitContainer/EnergyMeter.value -= 1
	var val = $VSplitContainer/HSplitContainer/EnergyMeter.value
	if $VSplitContainer/HSplitContainer/EnergyMeter.value < 50:
		if first_sleep_appear == false:
			first_sleep_appear = true
			$VSplitContainer/HBoxContainer/Sleep.show()
			$VSplitContainer/HBoxContainer/Eat.show()
			$VSplitContainer/HBoxContainer/Study.show()
			$VSplitContainer/HBoxContainer/Socialize.show()
		#$VSplitContainer/HSplitContainer/EnergyMeter.get("custom_styles/fg").set_bg_color(Color(
		#	1.0 if val<50 else (2 - 2*(val/100)),
		#	1.0 if val>50 else (2*(val/100)),
		#	0,1))
		# Assuming you have a reference to your EnergyMeter node
		#var progressbar = $VSplitContainer/HSplitContainer/EnergyMeter
		#print("Hello1")
		# Create a new ColorRect as the background
		#var background = ColorRect.new()
		#print("Hello2")
		#background.color = Color(0.2, 0.2, 0.2)  # Set the desired background color
		#print("Hello3")
		#progressbar.add_child(background)

		# Convert the ColorRect to a Texture
		#var texture = background.get_texture()
		#print("Hello4")
		# Set the Texture as the background of the ProgressBar
		#progressbar.background = texture
		#print("Hello5")
	#var pf = get_node("../scenes/ProjectFactory")
	
	
	#RNG generate a bug
	if rand_range(1, 100) > 90:
		# generate a random location for the bug button
		pf.generateProject("Bug " + str(count))
		count += 1
		
	#$scenes/ProjectFactory.generateProject("Testing " + str(count))

	#print($ProjectFactory.project_list)


func _on_Drink_Coffee_pressed():
	if sleeping == true:
		return

	main.update_money(-1)
	$VSplitContainer/HSplitContainer/EnergyMeter.value = 100
	$VSplitContainer/HSplitContainer/EnergyMeter.show()
	$VSplitContainer/HSplitContainer/Label.show()
	$Timer.start()
	if computer_boot_flag == 0:
		computer_boot_flag = 1
		$VSplitContainer/BootComputer.show()
	if removed == true:
		print('adding the child back')
		print(removable)
		$VSplitContainer/HSplitContainer2.add_child(removable)
		$VSplitContainer/HSplitContainer2/HelloWorld.show()

func _on_WalkDesk_pressed():
	if sleeping == true:
		return
	$VSplitContainer/WalkDesk.hide()
	$VSplitContainer/DrinkCoffee.show()


func _on_Boot_Computer_pressed():
	if sleeping == true:
		return
	$VSplitContainer/BootComputer.hide()
	# TODO play animation of bootup
	# text fade in
	$VSplitContainer/GameProgress/GameCompletion2.show()
	$VSplitContainer/GameProgress/Percent.show()
	$VSplitContainer/HBoxContainer2/Art.show()
	$VSplitContainer/HBoxContainer2/Music.show()
	$VSplitContainer/HBoxContainer2/Code.show()
	$VSplitContainer/HSplitContainer2/Label.show()
	$VSplitContainer/HSplitContainer2/HelloWorld.show()
	
	# TODO this is where I lay out the rest of the primary round 1 properties and things to track
	# trigger game progress and bugs as well



func _on_HelloWorld_gui_input(event):
	if sleeping == true:
		return
	if $VSplitContainer/HSplitContainer/EnergyMeter.value == 0:
		removed = true
		$VSplitContainer/HSplitContainer2/HelloWorld.get_parent().remove_child($VSplitContainer/HSplitContainer2/HelloWorld)
		
		#$VSplitContainer/HSplitContainer2/HelloWorld.set_process_input(false)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length = len($VSplitContainer/HSplitContainer2/HelloWorld.text)
		#print($VSplitContainer/HSplitContainer2/HelloWorld.max_length)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length -= 1
		
		


func _on_SleepButton_pressed():
	sleeping = true
	$SleepTimer.start()


func _on_SleepTimer_timeout():
	sleeping = false


func _on_Study_pressed():
	programming_skill += 0.001


func _on_Code_pressed():
	$VSplitContainer/GameProgress/Percent.value += 1*programming_skill
	programming_skill += 0.0001
