extends Timer

var can_start: bool = true
var max_idx := 0
var task_list: TaskList

func _ready() -> void:
	timeout.connect(start_task)
	SignalBus.can_start_task.connect(func () -> void: can_start = true)

func set_task_list(tl: TaskList) -> void:
	task_list = tl
	G.color_light.block = true
	if not can_start:
		await SignalBus.can_start_task
	var array := tl.array
	var task_lists: Array[ITaskData]
	var current_type: ITaskData.TaskType
	can_start = false
	max_idx = -1
	for i in array:
		if max_idx == -1:
			current_type = i.type
			max_idx = 0
		if current_type == i.type:
			task_lists.append(i)
		else:
			register_tasks(current_type, task_lists)
			current_type = i.type
			task_lists.append(i)
	register_tasks(current_type, task_lists)
	start_task()

func start_task() -> void:
	#for i in range(max_idx):
		#await get_tree().create_timer(.1).timeout
		#SignalBus.task_started.emit(i)
		#await SignalBus.task_completed
	SignalBus.task_started.emit(task_list.type)
	await SignalBus.task_completed
	start(3)

func register_tasks(current_type: ITaskData.TaskType, task_lists: Array[ITaskData]) -> void:
	match current_type:
		ITaskData.TaskType.BONFIRE:
			G.bonfire.register(current_type, task_lists)
		ITaskData.TaskType.COLORLIGHT:
			G.color_light.block = false
			G.color_light.register(current_type, task_lists)
	task_lists.clear()
	max_idx += 1
