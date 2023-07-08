extends Control

var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main.update_money(0)
	get_node("clicker").connect("pressed", self, "_on_a1_click")

func _on_a1_click():
	main.update_money(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
