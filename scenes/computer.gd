extends TextureRect
class_name Computer

@onready var grid: GridContainer = $GridContainer

var slots: Array[ComputerSlot] = []

var current_slot := 0

func _ready() -> void:
	slots.clear()
	var children := grid.get_children()
	for slot in children:
		if slot is ComputerSlot:
			slots.append(slot)
			slot.hide()
	
	G.computer = self

func show_slot(slot_texture: Texture2D) -> void:
	if current_slot == slots.size():
		return
	var slot := slots[current_slot]
	slot.show()
	slot.texture = slot_texture
	print(slot.name)
	current_slot += 1

func hide_slot() -> void:
	var temp_slot := current_slot - 1
	if temp_slot < 0:
		return
	slots[temp_slot].hide()
	print(slots[temp_slot].name)
	current_slot = temp_slot

func clear() -> void:
	for slot in slots:
		slot.hide()
	current_slot = 0
