extends Control
class_name DecoderManager

const START_POS := 360
const END_POS := 0

@export var decoder: Decoder
@export_subgroup("Tween", "_tween_")
@export var _tween_easing: Tween.EaseType
@export var _tween_trans: Tween.TransitionType
@export_range(.1, 1.5, .1) var _tween_duration := .3

@onready var bonfire_grid: GridContainer = %BonfireGrid
@onready var color_light_grid: GridContainer = %ColorLightGrid
@onready var toggle_button: Button = %ToggleButton
var decoded: Array[SlotData]
var _tween: Tween

func _init() -> void:
	G.decoder_manager = self

func _ready() -> void:
	toggle_button.toggled.connect(func(toggled: bool) -> void:
		bonfire_grid.visible = not toggled
		color_light_grid.visible = toggled
	)
	grids_setup()

func grids_setup() -> void:
	var dict: Dictionary[ITaskData.TaskType, Array] = decoder.get_controls()
	var list_bonfire := dict[ITaskData.TaskType.BONFIRE]
	var list_color := dict[ITaskData.TaskType.COLORLIGHT]
	for c in list_bonfire:
		bonfire_grid.add_child(c)
	for c in list_color:
		color_light_grid.add_child(c)

func decode(task_list: TaskList) -> void:
	decoded = decoder.decode(task_list)

func compare(slot_list: Array[SlotData]) -> bool:
	return decoded == slot_list

func show_window() -> void:
	_tween_pos(END_POS)

func hide_window() -> void:
	_tween_pos(START_POS)

func _tween_pos(to_y: int) -> void:
	if _tween: _tween.kill()
	_tween = create_tween().set_ease(_tween_easing).set_trans(_tween_trans)
	_tween.tween_property(self, "position:y", to_y, _tween_duration)
