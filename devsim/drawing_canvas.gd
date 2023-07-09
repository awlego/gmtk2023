extends Node2D

var drawing = false
var last_position
var brush_color = Color(1, 0, 0)  # Default brush color is red
#var brush_color = Color(0.38671875, 0.2345375, 0.2345375)
var line_node: Line2D


func _ready():
	line_node = $Line2D
	#line_node = Line2D.new()
	line_node.width = 10
	line_node.default_color = Color(0.38671875, 0.2345375, 0.2345375)

	add_child(line_node)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			drawing = true
			#print("event pos", event.position)
			last_position = event.position
			line_node.add_point(last_position)
			update()
		elif event.button_index == BUTTON_LEFT:
			drawing = false

	if event is InputEventMouseMotion and drawing:
		line_node.add_point(event.position)
		last_position = event.position
		update()

func _draw():
	#print("draw called?")
	draw_lin()
	
func draw_lin():
	if line_node.get_point_count() > 1:
		var points = line_node.get_points()
		var point_count = line_node.get_point_count()
		var count = 0
		for i in range(point_count - 1):
			count += 1
			var rect = self.get_parent().get_parent().get_global_rect()
			if rect.has_point(points[i]) and rect.has_point(points[i+1]):
				draw_line(points[i], points[i + 1], brush_color, 5.0)
