class_name CountDownInterface
extends CanvasLayer

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GameManager.time_scale_changed.connect(time_scale_change)

func time_scale_change(new_value : float):
	anim.speed_scale = 1.0 / new_value

func run_down_animation(new_value : int):
	label.text = str(new_value + 1)
	label_2.text = str(new_value)
	anim.play("Down")
