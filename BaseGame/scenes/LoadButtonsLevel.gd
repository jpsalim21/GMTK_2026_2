extends GridContainer

@export var list_levels : Array[String] = []
const LEVEL_BUTTON = preload("uid://ds50it0w3g756")

func _ready() -> void:
	var index = 1
	for level in list_levels:
		var new_button : Button = LEVEL_BUTTON.instantiate()
		add_child(new_button)
		new_button.text = str(index)
		index += 1
		new_button.pressed.connect( SceneController.changeSceneTo.bind(level) )
	
