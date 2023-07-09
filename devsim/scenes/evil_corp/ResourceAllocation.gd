extends GridContainer

export var total_points : int = 20
var points_in_resources = [0, 0, 0, 0]
var resource_names = ["Research & Development", "Company Growth", "Advertising", "Employee Benefits"]
var NUM_RESOURCES = 4

func _ready():
	update_points_labels()
	hook_up_buttons()

func hook_up_buttons():
	for i in range(NUM_RESOURCES):
		var _unused = get_node('Resource ' + str(i + 1)).get_node("Increment").connect("pressed", self, "_on_increment_button_pressed", [i])
		_unused = get_node('Resource ' + str(i + 1)).get_node("Decrement").connect("pressed", self, "_on_decrement_button_pressed", [i])
		
func sum_array(array):
	var sum = 0
	for item in array:
		sum += item
	return sum

func update_points_labels():
	$"Points Available".text = "Remaining Points: " + str(total_points - sum_array(points_in_resources))
	for i in range(NUM_RESOURCES):
		var s = 'Resource ' + str(i + 1) + '/Resource Points'
		var node = get_node(s)
		node.text = resource_names[i] + ": " + str(points_in_resources[i])


func _on_increment_button_pressed(resource_index):
	if total_points - sum_array(points_in_resources) > 0:
		points_in_resources[resource_index] += 1
		update_points_labels()

func _on_decrement_button_pressed(resource_index):
	if points_in_resources[resource_index] > 0:
		points_in_resources[resource_index] -= 1
		update_points_labels()
