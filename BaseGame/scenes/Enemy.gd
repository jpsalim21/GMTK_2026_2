class_name Enemy
extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var level_controller: LevelController = %LevelController

@export var alpha_zero_color : Color

func _ready() -> void:
	area_entered.connect(area_entered_func)

func area_entered_func(area : Area2D):
	die()

func die():
	sprite.play("Die")
	level_controller.enemy_died()
	await sprite.animation_finished
	var tween = create_tween()
	tween.tween_property(sprite, "self_modulate", alpha_zero_color, 0.2)
	await tween.finished
	queue_free()
