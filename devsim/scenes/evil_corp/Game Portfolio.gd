extends PanelContainer

onready var grid = $VBoxContainer/GridContainer

var HEADERS = ["Game Title", "Time til Obsolete", "Critic Rating", "$ / sec"]

var game_entry1 = {game_title="Battlefield", time_left="00:07", rating="B", earning="$1000"}
var game_entry2 = {game_title="Battlefield2", time_left="00:10", rating="B", earning="$1000"}
var game_entry3 = {game_title="Battlefield3", time_left="00:05", rating="B", earning="$1000"}
var game_entry4 = {game_title="Battlefield4", time_left="00:20", rating="B", earning="$1000"}

onready var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	grid.columns = 7

	add_child(timer)
	timer.set_wait_time(1)  # Fire every second
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

	var i = 0
	
	# setup headers
	for child in grid.get_children():
		if child is Label and i < 4:
			child.text = HEADERS[i]
			i += 1
			
	_add_game(game_entry1)
	_add_game(game_entry2)
	_add_game(game_entry3)
	_add_game(game_entry4)

func _add_spacer():
	for i in range(grid.columns):
		var spacer = ColorRect.new()
		spacer.rect_min_size = Vector2(3, 3)
		spacer.color = Color(0, 0, 0, 1)
		grid.add_child(spacer)
	
func _add_game(game):
	_add_spacer()
	for i in range(grid.columns):
		if i % 2 == 1:
			var spacer = ColorRect.new()
			spacer.rect_min_size = Vector2(3, 3)
			spacer.color = Color(0, 0, 0, 1)
			grid.add_child(spacer)
		if i == 0:
			var text = Label.new()
			text.text = game.game_title
			grid.add_child(text)
		if i == 2:
			var text = Label.new()
			text.text = game.time_left
			grid.add_child(text)
		if i == 4:
			var text = Label.new()
			text.text = game.rating
			grid.add_child(text)
		if i == 6:
			var text = Label.new()
			text.text = game.earning
			grid.add_child(text)
			
func _remove_row(row_index):
	var num_rows = grid.get_child_count() / 14 + 1
	print(num_rows)
	var children = grid.get_children()
	for i in range(grid.get_child_count()):
		if (row_index * 14 <= i) and (i < (row_index+1) * 14):
			var child = children[i]
			grid.remove_child(child)

func _time_int_to_string(int_time):
	var minutes = int(int_time / 60)
	var seconds = int_time % 60
	var string_time = "%02d:%02d" % [minutes, seconds]
	return string_time
	
func _time_string_to_int(string_time):
	var parts = string_time.split(":")
	var minutes = int(parts[0])
	var seconds = int(parts[1])
	var total_seconds = minutes * 60 + seconds
	return total_seconds
			
func _calculate_row_index(i):
	return (i / 14)
	
	
func _remove_dead_games():
	var children = grid.get_children()
	var rows_to_delete = []
	for i in range(grid.get_child_count()):
		if i % 14 == 2 and i > 13:
			var child = children[i]
			var remaining_time = child.text
			var int_time = _time_string_to_int(remaining_time)			
			if int_time <= 0:
				var game_row_index = _calculate_row_index(i)
				rows_to_delete.append(game_row_index)
				
	for row in rows_to_delete:
		print("Deleting row: ", row)
		_remove_row(row)

func _update_times():
	var children = grid.get_children()
	for i in range(grid.get_child_count()):
		if i % 14 == 2 and i > 13:
			var child = children[i]
			var remaining_time = child.text
			var int_time = _time_string_to_int(remaining_time) - 1
			child.text = _time_int_to_string(int_time)	
			
func _on_Timer_timeout():
	_remove_dead_games()
	_update_times()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
