extends Button

var coffee

# Called when the node enters the scene tree for the first time.
func _ready():
	coffee = get_node("../Coffee")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AutoDrinker_pressed():
	print("drink")
	var timer = Timer.new()
	self.get_parent().add_child(timer)
	timer.connect("timeout", coffee, "_on_Timer_timeout")
	timer.start()

