extends MarginContainer
var stage1_preload = preload("res://scenes/Stage1.tscn")
var stage1 = stage1_preload.instance()
var stage0
var stage3_preload = preload("res://scenes/evil_corp/evil_corp.tscn")
var stage3 = stage3_preload.instance()

# Declare member variables here.
var clicks = 0
var stage = 0
var hours_enjoyed = 0
var hours_message = "Hours of gameplay enjoyed: "
var money = 1000
var title_node
var money_node
var enjoy_node

func click():
	clicks += 1
	update_title()
	if (stage == 0 && clicks >= 10):
		stage = 1
		set_stage(stage1)

func _on_update_clicks(diff):
	clicks += diff
	update_title()
	
func update_title():
	title_node.text = "Clicks: " + str(clicks)

func update_money(diff):
	money += diff
	money_node.text = "$" + str(money)

func update_enjoy(hours):
	hours_enjoyed += hours
	enjoy_node.text = hours_message + str(hours)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("v0/Stage0/Button").connect("pressed", self, "click")
	setup_warp()
	title_node = get_node("v0/TopBar/Title")
	money_node = get_node("v0/TopBar/Money")
	enjoy_node = get_node("v0/TopBar/Hours")
	stage1.main = self
	stage3.main = self
	stage0 = get_node("v0/Stage0")
	pass # Replace with function body.

func setup_warp():
	get_node("v0/Stage0/WarpS1").connect("pressed", self, "warpS1")
	get_node("v0/Stage0/WarpS3").connect("pressed", self, "warpS3")

func set_stage(stage):
	var v0 = get_node("v0")
	if (v0.get_child_count() > 1):
		v0.remove_child(v0.get_child(1))
	v0.add_child(stage)

func warpS1():
	clicks = 10
	update_title()
	set_stage(stage1)
	
func warpS3():
	money =  100000000
	var employees = 1000
	var game_portfolio = 0
	update_title()
	set_stage(stage3)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
