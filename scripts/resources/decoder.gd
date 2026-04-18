extends Resource
class_name Decoder

@export var decoder_list: Dictionary[ITaskData, SlotData]

func slot_data(task: ITaskData) -> SlotData:
	return decoder_list[task]

func decode(task_list: TaskList) -> Array[SlotData]:
	var s: Array[SlotData] = []
	var size := task_list.size()
	s.resize(size)
	for i in size:
		s[i] = slot_data(task_list.get_task(i))
	return s

func get_controls() -> Dictionary[ITaskData.TaskType, Array]:
	var keys := decoder_list.keys()
	var list: Dictionary[ITaskData.TaskType, Array] = {}
	for key: ITaskData in keys:
		var type := key.type
		if not list.has(type):
			list[type] = []
		list[type].append(key.get_control())
		list[type].append(decoder_list[key].get_control())
	return list
