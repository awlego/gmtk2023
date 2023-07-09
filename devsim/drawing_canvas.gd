extends Node2D

var drawing = false
var last_position
var brush_color = Color(1, 0, 0)  # Default brush color is red
#var brush_color = Color(0.38671875, 0.2345375, 0.2345375)
var line_node: Line2D
var pic_idx = 0

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
	var point_count = line_node.get_point_count()
	print(point_count)
	if point_count > 1:
		var points = line_node.get_points()
		
		var scene = self.get_parent().get_parent().get_parent().get_parent().get_parent()
		var did_draw = false


		for i in range(point_count - 1):
			var rect = self.get_parent().get_parent().get_global_rect()
			if rect.has_point(points[i]) and rect.has_point(points[i+1]):
				draw_line(points[i], points[i + 1], brush_color, 5.0)
				did_draw = true

		if did_draw == true:
			scene.art_progress.value += .000075 * point_count
			scene.game_progress.value = scene.art_progress.value + scene.music_progress.value + scene.code_progress.value
				


	if point_count > 500:
		line_node.clear_points()
		pic_idx = (pic_idx + 1) % 23
		self.get_parent().get_parent().texture = load("res://assets/backgrounds/BlueJam_" + str(pic_idx) + ".png")
		
