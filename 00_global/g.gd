extends Node

var computer: Computer

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("debug_add_slot"):
		#computer.show_slot()
	#elif event.is_action_pressed("debug_remove_slot"):
		#computer.hide_slot()

func computer_enter() -> void:
	computer.clear()

func remove_slot() -> void:
	computer.hide_slot()

func add_slot(data: SlotData) -> void:
	computer.show_slot(data.texture)
