extends Control

var main

func _ready():
	var _success = get_node("clicker").connect("pressed", self, "_on_a1_click")
	main.update_money(0)
	
func _on_a1_click():
	main.update_money(1)
