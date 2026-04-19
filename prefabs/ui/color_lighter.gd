extends TextureRect
class_name ColorLighter

signal cleared

@export var beam: float = .3

@onready var interval: Timer = $Interval
@onready var color_rect: TextureRect = $ColorRect

var dict: Dictionary[int, Array]
var is_clearing := true

func _init() -> void:
	G.color_light = self

func _ready() -> void:
	SignalBus.task_started.connect(try_to_start)
	#SignalBus.task_list_complete.connect(clear)
	SignalBus.color_lighter_added.connect(show)

func register(idx: int, array: Array[ITaskData]) -> void:
	#if not is_clearing: await cleared
	var arr: Array[Color]= []
	for i in array.size():
		var task := array[i]
		if task is ColorLight:
			arr.append(task.color)
	dict[idx] = arr

func try_to_start(idx: int) -> void:
	if dict.has(idx):
		start(dict[idx])

func start(array: Array[Color]) -> void:
	for c in array:
		color_rect.self_modulate = c
		interval.start(beam)
		await interval.timeout
		color_rect.self_modulate = Color.BLACK
		interval.start(beam)
		await interval.timeout
	SignalBus.task_completed.emit()

func clear() -> void:
	dict.clear()
	cleared.emit()
	is_clearing = true
