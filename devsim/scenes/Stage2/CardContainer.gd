extends Panel


var cards = []
var draggedCard = null
var stage

func move_card_to_top(card):
	card.raise()
	
func add_card(card):
	add_child(card)
	card.connect("gui_input", self, "input")
	#move_card_to_top(card)

func drag_started(card):
	draggedCard = card
	move_card_to_top(card)

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
				var mp = get_global_mouse_position()
				var parent = card.get_parent()
				var new_parent = self
				if is_inside(mp, $v/h2/FIRE):
					parent.remove_child(card)
					drag_ended()
					stage.fire_employee(card)
					return
				if is_inside(mp, $v/h):
					if is_inside(mp, $v/h/CoffeeRoom):
						new_parent = $v/h/CoffeeRoom
					elif is_inside(mp, $v/h/SocialRoom):
						new_parent = $v/h/SocialRoom
					elif is_inside(mp, $v/h/Training):
						new_parent = $v/h/Training
				if parent != new_parent:
					parent.remove_child(card)
					draggedCard.rect_position.y = 10
					new_parent.add_child(card)
					draggedCard.rect_position.x += parent.rect_position.x - new_parent.rect_position.x
#					if self != new_parent:
#						draggedCard.rect_position.x = 10 * new_parent.get_child_count()
#					else:
#						draggedCard.rect_position.x += parent.rect_position.x - new_parent.rect_position.x
				
				draggedCard.rect_position.x = min(new_parent.rect_size.x - draggedCard.rect_size.x, max(0, draggedCard.rect_position.x))
				draggedCard.rect_position.y = min(new_parent.rect_size.y - draggedCard.rect_size.y, max(0, draggedCard.rect_position.y))
					
				drag_ended()
	if event is InputEventMouseMotion and draggedCard:
		draggedCard.rect_position += event.relative

func is_inside(point, node):
	if node.rect_global_position.x <= point.x && point.x <= node.rect_global_position.x + node.rect_size.x:
		return node.rect_global_position.y <= point.y && point.y <= node.rect_global_position.y + node.rect_size.y
	return false

	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
