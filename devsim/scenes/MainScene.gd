extends MarginContainer
const EnjoyTimer = preload("res://scenes/EnjoyTimer.gd")
var stage1_preload = preload("res://scenes/Stage1.tscn")
var stage1 = stage1_preload.instance()
var stage2_preload = preload("res://scenes/Stage2/Stage2.tscn")
var stage2 = stage2_preload.instance()
var stage0
var stage3_preload = preload("res://scenes/evil_corp/evil_corp.tscn")
var stage3 = stage3_preload.instance()
var stage_opener_preload = preload("res://opening_scene.tscn")
var stage_opener = stage_opener_preload.instance()

# Declare member variables here.
var clicks = 0
var stage = 0
var hours_enjoyed = 0
var hours_message = "Hours of gameplay enjoyed: "
var money = 1000
var title_node
var money_node
var enjoy_node

onready var info_text = get_node("v0/TopBar/MarginContainer/Info")
onready var typing_speed_timer = get_node("v0/TopBar/MarginContainer/Info/TypingSpeed")
var text = "This is some text that will be typed out letter by letter."
var textIndex = 0
	
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
	enjoy_node.text = hours_message + str(hours_enjoyed)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var _unused = get_node("v0/Stage0/Button").connect("pressed", self, "click")
	setup_warp()
	title_node = get_node("v0/TopBar/Title")
	money_node = get_node("v0/TopBar/VBoxContainer/Money")
	enjoy_node = get_node("v0/TopBar/VBoxContainer/Hours")
	stage_opener.main = self
	stage1.main = self
	stage2.main = self
	stage3.main = self
	stage0 = get_node("v0/Stage0")
	
	info_text.margin_left = 10
	info_text.margin_top = 10
	info_text.bbcode_text = ""
	typing_speed_timer.start()


func setup_warp():
	var _unused = get_node("v0/Stage0/WarpS1").connect("pressed", self, "warpS1")
	_unused = get_node("v0/Stage0/WarpS2").connect("pressed", self, "warpS2")
	_unused = get_node("v0/Stage0/WarpS3").connect("pressed", self, "warpS3")
	_unused = get_node("v0/Stage0/WarpOpener").connect("pressed", self, "warpOpener")

func set_stage(stage_to_set):
	var v0 = get_node("v0")
	if (v0.get_child_count() > 1):
		v0.remove_child(v0.get_child(1))
	v0.add_child(stage_to_set)

func warpS1():
	clicks = 10
	update_title()
	set_stage(stage1)
	
func warpS2():
	money = 100000
	clicks = 10000
	update_title()
	update_money(0)
	set_stage(stage2)
	
func warpS3():
	money =  100000000
	var _employees = 1000
	var _game_portfolio = 0
	update_title()
	set_stage(stage3)

func warpOpener():
	set_stage(stage_opener)

func _on_TypingSpeed_timeout():	
	if textIndex < len(text):
		# Append the next character to the label's text
		info_text.bbcode_text += text[textIndex]
		info_text.percent_visible = 1.0  # Ensure the label is fully visible
		textIndex += 1
	else:
		typing_speed_timer.stop()
