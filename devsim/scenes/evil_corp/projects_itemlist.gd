extends ItemList

func _ready():	
	# Add items to the item list
	add_item("Item 1")
	add_item("Item 2 testing lots of text here what happens if I write an essay here")
	add_item("Item 3")
	add_item("Item 4")
	add_item("Item 5")
	get_parent().queue_sort()  # Forces an immediate update of the container

func _on_projects_item_selected(index):
	remove_item(index)
	get_parent().queue_sort()
	print(index)

