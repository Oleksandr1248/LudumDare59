extends Resource
class_name DayData

@export var tasks_list: Array[TaskList]
var idx := -1

func next_task_list() -> TaskList:
	idx += 1
	if _has_next_task():
		return tasks_list[idx]
	return null

func _has_next_task() -> bool:
	return idx < tasks_list.size()
