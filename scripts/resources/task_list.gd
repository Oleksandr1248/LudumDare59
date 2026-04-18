extends Resource
class_name TaskList

@export var array: Array[ITaskData]

func get_task(idx: int) -> ITaskData:
	return array[idx]

func size() -> int:
	return array.size()
