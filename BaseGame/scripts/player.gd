extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var revolver_sprite: AnimatedSprite2D = $AnimatedSprite2D

var revolverPosition: float 
const SPEED = 150.0

func _ready() -> void:
	revolverPosition = revolver_sprite.position.x

func _process(delta: float) -> void:
	
	
	var mousePosition = get_global_mouse_position()
	
	if global_position.x < mousePosition.x:
		revolver_sprite.flip_v = false
		revolver_sprite.position.x = revolverPosition
		player_sprite.flip_h = false
		
	else:
		revolver_sprite.position.x = - revolverPosition
		revolver_sprite.flip_v = true
		player_sprite.flip_h = true
		
	
	revolver_sprite.look_at(mousePosition)

	
"""
func shoot() -> void:
	revolver_sprite.play("shoot")
	await revolver_sprite.animation_finished
	revolver_sprite.play("idle")
"""


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	if direction.x == 0 && direction.y == 0:
		player_sprite.play("idle")
	else:
		player_sprite.play("walking")
	
	move_and_slide()
