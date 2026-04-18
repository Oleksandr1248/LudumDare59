extends Node

const DAY_1 = preload("uid://b4jaho16q8q72")

signal day_started
signal tasks_compited

var decoder_manager: DecoderManager
var computer: Computer
var bonfire: BonfireNode
var game_over := false
var day_is_started := false

func _ready() -> void:
	day_started.connect(func (): day_is_started = true)
	day_started.emit()
	next_task_list()

func _input(event: InputEvent) -> void:
	if day_is_started:
		if event.is_action_pressed("show_decoder"):
			decoder_manager.show_window()
		elif event.is_action_pressed("hide_decoder"):
			decoder_manager.hide_window()

func computer_enter() -> void:
	if game_over and not day_is_started: return
	var input := computer.slots_data
	if decoder_manager.compare(input):
		print("COMPLETE")
		computer.clear()
		tasks_compited.emit()
		next_task_list()
	else:
		print("ERROR")

func next_task_list() -> void:
	var task_list := DAY_1.next_task_list()
	if task_list:
		decoder_manager.decode(task_list)
	else:
		game_over = true
		print("YOU WIN")

func remove_slot() -> void:
	computer.hide_slot()

func add_slot(data: SlotData) -> void:
	computer.show_slot(data)
