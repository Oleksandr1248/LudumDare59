extends Control
class_name BonfireNode

@export var speed: float = 200
@export var time: float = 20.0
@onready var timer: Timer = $Timer
@onready var container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	G.bonfire = self
	G.tasks_compited.connect(stop)

func stop() -> void:
	timer.stop()
