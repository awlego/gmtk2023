extends Control

var main

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("h0/Buttons/Button").connect("pressed", self, "_on_a1_click")
	pass # Replace with function body.

func _on_a1_click():
	main._on_update_clicks(2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
