extends Node2D


# Declare member variables here. Examples:
var energy_meter



# Called when the node enters the scene tree for the first time.
func _ready():
	print("We are here")
	energy_meter = TextureProgress.new()
	energy_meter.max_value = 100
	energy_meter.value = 100
	energy_meter.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
