extends TextureRect
class_name Computer

@onready var grid: GridContainer = $GridContainer

var slots: Array[ComputerSlot] = []
var slots_data: Array[SlotData] = []

var current_slot := 0

func _ready() -> void:
	slots.clear()
	slots_data.clear()
	var children := grid.get_children()
	for slot in children:
		if slot is ComputerSlot:
			slots.append(slot)
			slot.hide()
	
	G.computer = self

func show_slot(slot_data: SlotData) -> void:
	if current_slot == slots.size():
		return
	var slot := slots[current_slot]
	slot.show()
	slot.texture = slot_data.texture
	slots_data.append(slot_data)
	current_slot += 1

func hide_slot() -> void:
	var temp_slot := current_slot - 1
	if temp_slot < 0:
		return
	slots[temp_slot].hide()
	slots_data.pop_back()
	current_slot = temp_slot

func clear() -> void:
	slots_data.clear()
	for slot in slots:
		slot.hide()
	current_slot = 0
