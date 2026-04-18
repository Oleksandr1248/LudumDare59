extends ITaskData
class_name ColorLight

@export var color: Color

func get_control() -> Control:
	var c := ColorRect.new()
	c.color = color
	c.custom_minimum_size = Vector2(32, 32)
	return c
