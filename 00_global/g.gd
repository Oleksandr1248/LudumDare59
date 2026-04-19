extends Node

var decoder_manager: DecoderManager
var game: Game
var computer: Computer
var bonfire: BonfireNode
var color_light: ColorLighter
var game_over := false
var day_is_started := false

func _ready() -> void:
	SignalBus.day_started.connect(func (): day_is_started = true)
	SignalBus.game_overed.emit(_on_game_overed)
	if not game.is_node_ready():
		await game.ready
	SignalBus.day_init.emit(0)

func _input(event: InputEvent) -> void:
	if day_is_started:
		if event.is_action_pressed("show_decoder"):
			#decoder_manager.show_window()
			decoder_manager.vision_change()
		#elif event.is_action_pressed("hide_decoder"):
			#decoder_manager.hide_window()

func computer_enter() -> void:
	if game_over and not day_is_started: return
	var input := computer.slots_data
	if decoder_manager.compare(input):
		#print("COMPLETE")
		game.complete()
		computer.clear()
		SignalBus.task_list_complete.emit()
	else:
		#print("ERROR")
		game.error()

func remove_slot() -> void:
	computer.hide_slot()

func add_slot(data: SlotData) -> void:
	computer.show_slot(data)

func _on_game_overed() -> void:
	game_over = true
	#print("YOU WIN")

func mute(toggled: bool) -> void:
	var v := .0 if toggled else 1.0
	AudioServer.set_bus_volume_linear(0, v)
