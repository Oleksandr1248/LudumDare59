extends Control
class_name KeyButton

@export var data: IKeyData
@onready var button: TextureButton = $TextureButton
@onready var symbol: TextureRect = %Symbol

func _ready() -> void:
	button.pressed.connect(data.key_pressed)
	symbol.texture = data.texture()
