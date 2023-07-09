extends Line2D

var texture_rect

func _ready():
	print(self.width)
	texture_rect = get_parent().get_parent().get_parent()

func _draw():
	print("oh yeah")

#func _process(delta):
#	if self.get_point_count() < 1:
#		return
	
	#var texture_rect_bounds = Rect2(texture_rect.get_global_position(), texture_rect.rect_size)
	#var new_point = self.points[self.get_point_count()-1]
	#var x_point_position = new_point.x
	#var y_point_position = new_point.y

	

	
	#print(texture_rect_bounds)
	#print(line2d_global_position)
	
	#var clamped_position_x = clamp(x_point_position, texture_rect_bounds[0], texture_rect_bounds[2])
	#var clamped_position_y = clamp(y_point_position, texture_rect_bounds[1], texture_rect_bounds[3])
	#set_global_position(clamped_position)
	#var clamped_pos = Vector2(clamped_position_x, clamped_position_y)
	#set_point_position(self.get_point_count()-1, clamped_pos)
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


	#var texture_rect_global_rect = texture_rect.get_global_rect()
	#var texture_rect_local_rect = texture_rect.rect
	#var line2d_global_position = global_position
	#var line2d_local_position = texture_rect.to_local(line2d_global_position)

	#var x = clamp(line2d_local_position.x, 0, texture_rect_local_rect.size.x)
	#var y = clamp(line2d_local_position.y, 0, texture_rect_local_rect.size.y)

	#line2d_local_position.x = x
	#line2d_local_position.y = y

	#line2d_global_position = texture_rect.to_global(line2d_local_position)
	#set_global_position(line2d_global_position)


