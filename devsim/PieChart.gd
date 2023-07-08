extends Control

var data = {
	"Company1": 30,
	"Company2": 20,
	"Company3": 50
}

var colors = {
	"Company1": Color(1, 0, 0, 1),  # red
	"Company2": Color(0, 1, 0, 1),  # green
	"Company3": Color(0, 0, 1, 1),   # blue
	"Company4": Color(0, 1, 1, 1)   # cyan
}

var font = preload("res://assets/UIFont.tres")

func _ready():
	update_pie_chart()

func _draw():
	var total_value = 0
	for company in data:
		total_value += data[company]

	var radius = min(rect_size.x, rect_size.y) / 2 - 10
	var center = rect_size / 2

	var start_angle = 0
	for company in data:
		var share = data[company] / total_value
		var arc_angle = share * 2 * PI
		var color = colors[company]

		var points = [center]
		for i in range(64):
			var angle = start_angle + i / 64.0 * arc_angle
			points.append(center + Vector2(cos(angle), sin(angle)) * radius)
		points.append(center + Vector2(cos(start_angle + arc_angle), sin(start_angle + arc_angle)) * radius)

		draw_colored_polygon(points, color)

		var mid_angle = start_angle + arc_angle / 2
		var text_pos = center + Vector2(cos(mid_angle), sin(mid_angle)) * (radius / 1.5)
		if share >= 0.05:
			draw_string(font, text_pos, str(int(share * 100)) + "%", Color(0, 0, 0, 1))
			
		var line_end = center + Vector2(cos(start_angle), sin(start_angle)) * radius
		draw_line(center, line_end, Color.black, 4.0)

		start_angle += arc_angle

func update_pie_chart():
	# Update the data as necessary, then call update() to redraw the pie chart
	data["Company1"] = rand_range(1, 50)
	data["Company2"] = rand_range(1, 50)
	data["Company3"] = rand_range(1, 50)
	update()
	
var i = 0
func _on_Timer_timeout():
	if (i % 2) == 0:
		data["Company1"] = rand_range(1, 50)
		data["Company2"] = rand_range(1, 50)
		data["Company3"] = rand_range(1, 50)
		data["Company4"] = rand_range(1, 50)
	else:
		data["Company1"] = rand_range(1, 50)
		data["Company2"] = rand_range(1, 50)
		data["Company3"] = rand_range(1, 50)
		data["Company4"] = 0
	i += 1
	update()

