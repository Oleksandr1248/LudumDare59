extends Resource
class_name DayData

enum OnStart {NULL, RAIN, RAIN_AND_COLOR}

@export var tasks_list: Array[TaskList]
@export var _on_start: OnStart

var idx := -1

func next_task_list() -> TaskList:
	idx += 1
	if _has_next_task():
		return tasks_list[idx]
	return null

func _has_next_task() -> bool:
	return idx < tasks_list.size()

func start() -> void:
	match _on_start:
		OnStart.RAIN:
			SignalBus.rain_started.emit()
		OnStart.RAIN_AND_COLOR:
			SignalBus.rain_started.emit()
			SignalBus.color_lighter_added.emit()
			SignalBus.show_tutor.emit(1)
