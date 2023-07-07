extends MarginContainer
var stage1 = preload("res://scenes/Stage1.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clicks = 0
var stage = 0
var title_node

func click():
	clicks += 1
	update_title()
	if (stage == 0 && clicks >= 10):
		var v0 = get_node("v0")
		var child_stage = get_node("v0/Stage0")
		v0.remove_child(child_stage)
		if is_instance_valid(child_stage):
			child_stage.queue_free()
		v0.add_child(stage1.instance())
		register_stage()

func _on_update_clicks(diff):
	clicks += diff
	update_title()
	
func update_title():
	title_node.text = "Clicks: " + str(clicks)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("v0/Stage0/Button").connect("pressed", self, "click")
	title_node = get_node("v0/TopBar/Title")
	pass # Replace with function body.

func register_stage():
	var v0 = get_node("v0")
	var stage = v0.get_child(1)
	stage.connect("update_clicks", self, "_on_update_clicks")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
