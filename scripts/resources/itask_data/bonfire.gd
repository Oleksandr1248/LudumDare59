extends ITaskData
class_name Bonfire

@export var texture: Texture2D

func get_control() -> Control:
	var c := TextureRect.new()
	c.texture = texture
	c.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	return c
