extends Node2D

var drawing = false
var last_position
var brush_color = Color(1, 0, 0)  # Default brush color is red
var line_node: Line2D

func _ready():
	line_node = Line2D.new()
	add_child(line_node)

func _input(event):
	print("NOT A CHANCE")
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			drawing = true
			last_position = event.position
			line_node.add_point(last_position)
		elif event.button_index == BUTTON_LEFT:
			drawing = false

	if event is InputEventMouseMotion and drawing:
		line_node.add_point(event.position)
		last_position = event.position
		update()

func _draw():
	draw_lin()
	
func draw_lin():
	if line_node.get_point_count() > 1:
		var points = line_node.get_points()
		var point_count = line_node.get_point_count()
		
		for i in range(point_count - 1):
			draw_line(points[i], points[i + 1], brush_color, 2.0)
