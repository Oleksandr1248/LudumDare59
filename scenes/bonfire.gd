extends Control
class_name BonfireNode

const PUFF_Y := 24
const SPACE := 20

@onready var marker_2d: Marker2D = $Marker2D

var dict: Dictionary[int, PuffsSmoke]
var _tween: Tween

func _init() -> void:
	G.bonfire = self

func _ready() -> void:
	SignalBus.task_started.connect(try_to_start)
	SignalBus.task_list_complete.connect(clear)

func register(idx: int, array: Array[ITaskData]) -> void:
	var puffs := PuffsSmoke.new()
	var temp_size_y := 0
	for i in array.size():
		var c := array[i].get_control()
		puffs.add_child(c)
		temp_size_y = i * (PUFF_Y + SPACE)
		c.position.y = temp_size_y
	puffs.puff_size = Vector2(80, temp_size_y)
	add_child(puffs)
	dict[idx] = puffs

func start_tween(c: PuffsSmoke) -> void:
	if _tween: _tween.kill()
	var end_pos_y: int = floor(marker_2d.position.y - c.get_puff_size().y)
	_tween = create_tween()
	_tween.tween_property(c, "position:y", end_pos_y, 5)
	await _tween.finished
	if c:
		c.position.y = 0
	SignalBus.task_completed.emit()

func clear() -> void:
	if _tween: _tween.kill()
	dict.clear()
	for ch in get_children():
		if ch is PuffsSmoke:
				ch.queue_free()
	SignalBus.can_start_task.emit()

func try_to_start(idx: int) -> void:
	if dict.has(idx):
		start_tween(dict[idx])


class PuffsSmoke extends Control:
	var puff_size := Vector2.ZERO
	var idx := 0
	
	func get_puff_size() -> Vector2:
		var child_count := get_child_count()
		if child_count == 0: return Vector2.ZERO
		var v := puff_size
		v.y += BonfireNode.PUFF_Y
		return v
