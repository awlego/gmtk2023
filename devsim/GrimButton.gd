extends Button
class_name GrimButton

signal cleanup

func _ready():
	connect("pressed", self, "_on_pressed")

func _on_pressed():
	get_parent().remove_child(self)
	emit_signal("cleanup", self)
	self.queue_free()
