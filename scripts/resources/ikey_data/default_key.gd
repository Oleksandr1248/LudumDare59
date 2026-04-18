extends IKeyData
class_name DefaultKey

@export var data: SlotData

func key_pressed() -> void:
	G.add_slot(data)

func texture() -> Texture2D:
	return data.texture
