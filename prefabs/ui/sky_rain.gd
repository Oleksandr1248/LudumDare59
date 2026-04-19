extends TextureRect
class_name SkyRain

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
var is_raining := false

func _ready() -> void:
	SignalBus.rain_started.connect(turn_rain.bind(true))
	SignalBus.day_ended.connect(turn_rain.bind(false))

func turn_rain(toggle: bool) -> void:
	if is_raining and not toggle: SignalBus.rain_ended.emit()
	is_raining = toggle
	visible = toggle
	cpu_particles_2d.emitting = toggle
