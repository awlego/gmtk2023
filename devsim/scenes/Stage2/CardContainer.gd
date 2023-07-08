extends Panel


var cards = []
var draggedCard = null

func drag_started(card):
	draggedCard = card

func drag_ended():
	draggedCard = null

func input(event, card):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				# Mouse button pressed (mouse down)
				drag_started(card)
			else:
				# Mouse button released (mouse up)
				drag_ended()
	if event is InputEventMouseMotion and draggedCard:
		draggedCard.rect_position += event.relative


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
