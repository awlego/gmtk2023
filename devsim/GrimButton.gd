extends Button


# Declare member variables here. Examples:
signal cleanup

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_pressed")

func _on_pressed():
	get_parent().remove_child(self)
	emit_signal("cleanup", self)
	self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
