extends Node2D

func _ready():
	# Create a new GridContainer
	var grid = GridContainer.new()
	
	# Set it to have 4 columns
	grid.columns = 4
	
	# Add it to the current scene
	add_child(grid)
	
	# Add rows to the grid
	for i in range(4):  # Add 4 rows
		# For each row, add 4 columns
		for j in range(5):
			# Create a new Label
			var label = Label.new()
			
			# Set the text of the Label to some placeholder text
			label.text = "Row %d, Column %d" % [i, j]
			
			# Add the Label to the grid
			grid.add_child(label)

		# If this is not the last row, add a line separator

		var line = x.new()
		line.rect_min_size = Vector2(800, 2) # Change the size to suit your need
		grid.add_child(line)
