extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var energy_meter
var computer_boot_flag = 0
var removed = false
onready var removable = get_node("$VSplitContainer/HSplitContainer2/HelloWorld")

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$VSplitContainer/HSplitContainer/ProgressBar.hide()
	$VSplitContainer/HSplitContainer/Label.hide()
	$VSplitContainer/DrinkCoffee.hide()
	$VSplitContainer/BootComputer.hide()
	$VSplitContainer/HSplitContainer2/Label.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.hide()
	$VSplitContainer/HSplitContainer2/HelloWorld.max_length = 20

	#$HSplitContainer/ProgressBar.value = 100
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	$VSplitContainer/HSplitContainer/ProgressBar.value -= 1

	$ProjectFactory.generateProject("Testing " + str(count))
	count += 1
	print($ProjectFactory.project_list)


func _on_Drink_Coffee_pressed():
	$VSplitContainer/HSplitContainer/ProgressBar.value = 100
	$VSplitContainer/HSplitContainer/ProgressBar.show()
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
	$VSplitContainer/WalkDesk.hide()
	$VSplitContainer/DrinkCoffee.show()


func _on_Boot_Computer_pressed():
	$VSplitContainer/BootComputer.hide()
	# TODO play animation of bootup
	# text fade in
	$VSplitContainer/HSplitContainer2/Label.show()
	$VSplitContainer/HSplitContainer2/HelloWorld.show()



func _on_HelloWorld_gui_input(event):
	if $VSplitContainer/HSplitContainer/ProgressBar.value == 0:
		removed = true
		$VSplitContainer/HSplitContainer2/HelloWorld.get_parent().remove_child($VSplitContainer/HSplitContainer2/HelloWorld)
		
		#$VSplitContainer/HSplitContainer2/HelloWorld.set_process_input(false)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length = len($VSplitContainer/HSplitContainer2/HelloWorld.text)
		#print($VSplitContainer/HSplitContainer2/HelloWorld.max_length)
		#$VSplitContainer/HSplitContainer2/HelloWorld.max_length -= 1
		
		


