extends PanelContainer

var data = {
	"Your Company": 10,
	"Digital Crafts": 10,
	"Pebblestar Games": 15,
	"Youbiwork": 25,
	"Mischievous Hound": 40
}

var company_names = ["Your Company", "Digital Crafts", "Pebblestar Games", "Youbiwork", "Mischievous Hound"]

var colors = {
	"Your Company": Color(1, 0, 0, 1),  # red
	"Digital Crafts": Color(0, 1, 0, 1),  # green
	"Pebblestar Games": Color(1, .7, 0, 1),  # orange
	"Youbiwork": Color(0, 1, 1, 1),   # cyan
	"Mischievous Hound": Color(1, 1, 0, 1)   # yellow
}

var font = preload("res://assets/UIFont.tres")
var debug = false
onready var legend_container

func _ready():
	legend_container = get_node("VBoxContainer/HBoxContainer/LegendContainer")
	update_pie_chart()

func update_legend():
	# First, remove all existing legend labels
	for child in legend_container.get_children():
		child.queue_free()
		
	# Then, create a new Label for each company and add it to the legend container
	for company in data:
		var label = Label.new()
		label.text = company
		label.add_color_override("font_color", colors[company])
		legend_container.add_child(label)
	#

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
	
	update_legend()



func update_pie_chart():
	# Update the data as necessary, then call update() to redraw the pie chart
	for company_name in company_names:
		data[company_name] += rand_range(-5, 5) 
	update()
	
var i = 0
func _on_Timer_timeout():
	if debug == true:
		if (i % 2) == 0:
			data["Company1"] = rand_range(1, 50)
			data["Company2"] = rand_range(1, 50)
			data["Company3"] = rand_range(1, 50)
			data.erase("Company4")
		else:
			data["Company1"] = rand_range(1, 50)
			data["Company2"] = rand_range(1, 50)
			data["Company3"] = rand_range(1, 50)
			data["Company4"] = rand_range(1, 50)
		i += 1
		update()

