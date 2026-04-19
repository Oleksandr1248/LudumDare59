extends Timer

var max_idx := 0

func _ready() -> void:
	timeout.connect(start_task)

func set_task_list(tl: TaskList) -> void:
	var array := tl.array
	var task_lists: Array[ITaskData]
	var current_type: ITaskData.TaskType
	max_idx = -1
	for i in array:
		if max_idx == -1:
			current_type = i.type
			max_idx = 0
		if current_type == i.type:
			task_lists.append(i)
		else:
			register_tasks(current_type, task_lists)
			task_lists.append(i)
	register_tasks(current_type, task_lists)
	start_task()

func start_task() -> void:
	for i in range(max_idx):
		SignalBus.task_started.emit(i)
		await SignalBus.task_completed
	start()

func register_tasks(current_type: ITaskData.TaskType, task_lists: Array[ITaskData]) -> void:
	match current_type:
		ITaskData.TaskType.BONFIRE:
			G.bonfire.register(max_idx, task_lists)
		ITaskData.TaskType.COLORLIGHT: pass
	task_lists.clear()
	max_idx += 1
