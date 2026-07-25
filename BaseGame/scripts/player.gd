extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var revolver_sprite: Sprite2D = $RevolverSprite

var revolverPosition: float 
const SPEED = 150.0

func _ready() -> void:
	#revolverPosition = revolver_sprite.position.x
	pass

func _process(delta: float) -> void:
	var mousePosition = get_global_mouse_position()
	
	'''
	if global_position.x < mousePosition.x:
		revolver_sprite.flip_v = false
		revolver_sprite.position.x = revolverPosition
		player_sprite.flip_h = false
	else:
		revolver_sprite.position.x = - revolverPosition
		revolver_sprite.flip_v = true
		player_sprite.flip_h = true
	'''
	
	
	#revolver_sprite.look_at(mousePosition)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseRight"):
		Engine.time_scale = 0.4
	elif event.is_action_released("MouseRight"):
		Engine.time_scale = 1.0
	
