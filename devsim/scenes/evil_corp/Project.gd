extends Node

class_name Project

var title = ""
var text = ""
var complete = false
var money_cost = 0
var research_cost = 0
var project_index = 0
var project_unlocks = 0


func _init(_title="", _text="", _complete = false, _money_cost=0, _research_cost=0, _project_index=0, _project_unlocks=0):
	title = _title
	text = _text
	complete = _complete
	money_cost = _money_cost
	research_cost = _research_cost
	project_index = _project_index
	project_unlocks = _project_unlocks
	
