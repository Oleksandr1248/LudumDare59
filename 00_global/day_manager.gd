extends Node

const list: Array[DayData] = [
	preload("uid://b4jaho16q8q72")
]

var idx := 0

func _ready() -> void:
	SignalBus.task_list_complete.connect(next_task_list)
	SignalBus.day_init.connect(_on_day_init)
	SignalBus.all_day_completed.connect(SignalBus.game_overed.emit)

func next_task_list() -> void:
	var task_list := list[idx].next_task_list()
	if task_list:
		G.decoder_manager.decode(task_list)
		TaskManager.set_task_list(task_list)
	else:
		SignalBus.day_init.emit(idx + 1)


func _on_day_init(i: int) -> void:
	idx = i
	if idx < list.size():
		SignalBus.day_started.emit()
		next_task_list()
	else:
		SignalBus.game_overed.emit()

#const DAY_LIST = preload("uid://f4jlu5h6b40e")
#func next_task_list() -> void:
	#var task_list := DAY_LIST.next_task_list()
	#if task_list:
		#G.decoder_manager.decode(task_list)
		#TaskManager.set_task_list(task_list)
	##else:
		##()
