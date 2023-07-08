extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var energy_meter

# Called when the node enters the scene tree for the first time.
func _ready():
	$VSplitContainer/HSplitContainer/ProgressBar.hide()
	$VSplitContainer/HSplitContainer/Label.hide()


	#$HSplitContainer/ProgressBar.value = 100
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	$VSplitContainer/HSplitContainer/ProgressBar.value -= 1


func _on_Drink_Coffee_pressed():
	$VSplitContainer/HSplitContainer/ProgressBar.value = 100
	$VSplitContainer/HSplitContainer/ProgressBar.show()
	$VSplitContainer/HSplitContainer/Label.show()
	$Timer.start()

