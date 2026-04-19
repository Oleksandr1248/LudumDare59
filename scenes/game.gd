extends Node2D
class_name Game

@onready var text_label: Label = %TextLabel
@onready var day_panel: PanelContainer = %DayPanel

var _tween: Tween

func _init() -> void:
	G.game = self

func _ready() -> void:
	SignalBus.day_started.connect(tween_panel)
	SignalBus.game_overed.connect(func () -> void:
		day_panel.position.y = 0
		text_label.text = "GAME ENDED"
		text_label.add_theme_color_override("font_color", Color(0.918, 0.618, 0.0, 1.0)))

func tween_panel() -> void:
	text_label.text = "DAY %d" % (DayManager.idx + 1)
	if _tween: _tween.kill()
	_tween = create_tween()
	await _tween.tween_property(day_panel, "position:y", 0, .8).finished
	await get_tree().create_timer(.4).timeout
	_tween = create_tween()
	_tween.tween_property(day_panel, "position:y", -360, .4)
