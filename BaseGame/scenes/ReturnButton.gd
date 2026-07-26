extends Button

var menu_inicial : String = "res://BaseProject/Menus/MenuInicial.tscn"

func _ready() -> void:
	pressed.connect(pressed_func)

func pressed_func():
	SceneController.changeSceneTo(menu_inicial)
