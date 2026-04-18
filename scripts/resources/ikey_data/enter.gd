extends IKeyData
class_name Enter

@export var key_texture: Texture2D

func key_pressed() -> void:
	G.computer_enter()

func texture() -> Texture2D:
	return key_texture
