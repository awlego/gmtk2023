extends Sprite

const ROOMBA = preload("res://assets/images/Roomba2.png")
var tween
var target
var wall = 0
var last = 1 # 0: rotate, 1: move

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = Tween.new()
	add_child(tween)
	self.texture = ROOMBA
	self.position = Vector2(0, randi() % int(get_viewport().get_visible_rect().size.y))
	self.z_index = 4
	pass # Replace with function body.

func rotate_to_target():
	var target_r = position.angle_to_point(target) - 1.57
	var target_rot = target_r * 360 / 2 / 3.14
	var diff = int(rotation_degrees - target_rot) % 360
	if diff > 180:
		diff -= 360
	if diff < -180:
		diff += 360
	tween.interpolate_property(self, "rotation", rotation, target_r, abs(diff) / 60.0)
	tween.start()

func move_to_target():
	var time = position.distance_to(target) / 300.0
	tween.interpolate_property(self, "position", position, target, time)
	tween.start()

func find_target():
	var targetwall = randi() % 3
	if targetwall >= wall:
		targetwall += 1
	if targetwall == 0:
		target = Vector2(0, randi() % int(get_viewport().get_visible_rect().size.y))
	elif targetwall == 1:
		target = Vector2(randi() % int(get_viewport().get_visible_rect().size.x), int(get_viewport().get_visible_rect().size.y))
	elif targetwall == 2:
		target = Vector2(int(get_viewport().get_visible_rect().size.x), randi() % int(get_viewport().get_visible_rect().size.y))
	else:
		target = Vector2(randi() % int(get_viewport().get_visible_rect().size.x), 0)
	
	wall = targetwall
	return

func _process(_delta):
	if tween.is_active():
		return
	
	if last == 0:
		move_to_target()
		last = 1
		return
	else:
		find_target()
		rotate_to_target()
		last = 0
		return
