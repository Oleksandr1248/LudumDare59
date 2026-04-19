extends Node2D
class_name Game

@onready var text_label: Label = %TextLabel
@onready var day_panel: PanelContainer = %DayPanel
@onready var audio_complete: AudioStreamPlayer = $AudioComplete
@onready var audio_error: AudioStreamPlayer = $AudioError
@onready var vinet: Panel = %Vinet
@onready var vinet_timer: Timer = %VinetTimer
@onready var mute_button: TextureButton = %MuteButton
@onready var audio_forest: AudioStreamPlayer = $AudioForest
@onready var audio_rain: AudioStreamPlayer = $AudioRain

var _tween: Tween

func _init() -> void:
	G.game = self

func _ready() -> void:
	SignalBus.day_started.connect(tween_panel)
	SignalBus.game_overed.connect(func () -> void:
		day_panel.position.y = 0
		text_label.text = "GAME ENDED"
		text_label.add_theme_color_override("font_color", Color(0.918, 0.618, 0.0, 1.0)))
	SignalBus.rain_started.connect(rain_toggled.bind(true))
	SignalBus.rain_ended.connect(rain_toggled.bind(false))
	mute_button.toggled.connect(G.mute)

func tween_panel() -> void:
	text_label.text = "DAY %d" % (DayManager.idx + 1)
	if _tween: _tween.kill()
	_tween = create_tween()
	await _tween.tween_property(day_panel, "position:y", 0, .8).finished
	await get_tree().create_timer(.4).timeout
	_tween = create_tween()
	_tween.tween_property(day_panel, "position:y", -360, .4)

func complete() -> void:
	audio_complete.play()
	vinet_bleam(Color.LAWN_GREEN)

func error() -> void:
	audio_error.play()
	vinet_bleam(Color.DARK_RED)

func vinet_bleam(c: Color) -> void:
	vinet.show()
	vinet.self_modulate = c
	vinet_timer.start(.2)
	await vinet_timer.timeout
	vinet.hide()

func rain_toggled(toggle: bool) -> void:
	if toggle:
		audio_rain.play()
		audio_forest.stop()
	else:
		audio_rain.stop()
		audio_forest.play()
