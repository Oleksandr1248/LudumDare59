extends IKeyData
class_name BackSpace

@export var key_texture: Texture2D

func key_pressed() -> void:
	G.remove_slot()

func texture() -> Texture2D:
	return key_texture
