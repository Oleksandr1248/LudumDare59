@abstract
extends Resource
class_name ITaskData

enum TaskType {BONFIRE, COLORLIGHT}

@export var type: TaskType

@abstract
func get_control() -> Control
