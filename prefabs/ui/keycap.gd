extends Control
class_name KeyButton

@export var data: IKeyData
@onready var button: TextureButton = $TextureButton
@onready var symbol: TextureRect = %Symbol
@onready var audio_hover: AudioStreamPlayer = $AudioHover
@onready var audio_click: AudioStreamPlayer = $AudioClick

func _ready() -> void:
	button.pressed.connect(func () -> void:
		data.key_pressed()
		audio_click.play()
	)
	button.mouse_entered.connect(audio_hover.play)
	symbol.texture = data.texture()
