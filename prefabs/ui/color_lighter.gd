extends TextureRect
class_name ColorLighter

@export var beam: float = .3

@onready var interval: Timer = $Interval
@onready var color_rect: ColorRect = $ColorRect

var dict: Dictionary[int, Array]

func _init() -> void:
	G.color_light = self

func _ready() -> void:
	SignalBus.task_started.connect(try_to_start)
	SignalBus.task_list_complete.connect(clear)

func register(idx: int, array: Array[ITaskData]) -> void:
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
	color_rect.show()
	for c in array:
		color_rect.color = c
		interval.start(beam)
		await interval.timeout
	SignalBus.task_completed.emit()
	color_rect.hide()

func clear() -> void:
	dict.clear()
