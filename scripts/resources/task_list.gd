extends Resource
class_name TaskList

@export var array: Array[ITaskData]
@export var type: ITaskData.TaskType

func get_task(idx: int) -> ITaskData:
	return array[idx]

func size() -> int:
	return array.size()
