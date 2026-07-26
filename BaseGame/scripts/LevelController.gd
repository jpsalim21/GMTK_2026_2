class_name LevelController
extends Node

@export var player : Player
@onready var enemy_father : Node2D = $"../Inimigos"
@onready var timer: Timer = $Timer
var selecao_fases : String = "res://BaseGame/scenes/SelecaoFases.tscn"

var enemy_number : int

var ended : bool = false

func _ready() -> void:
	enemy_number = enemy_father.get_child_count()

func enemy_died():
	enemy_number -= 1
	if enemy_number <= 0:
		ended = true
		timer.start(1.0)
		await timer.timeout
		SceneController.changeSceneTo(selecao_fases)

func player_shooted(bullets_left : int):
	if bullets_left <= 0 and !ended:
		timer.start(2.0)
		await timer.timeout
		SceneController.reloadCurrentScene()
