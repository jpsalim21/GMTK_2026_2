extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var revolver_sprite: Sprite2D = $RevolverSprite
@onready var ray_1: RayCast2D = $Raycasts/Ray1
@onready var ray_2: RayCast2D = $Raycasts/Ray2

var revolverPosition: float 
const SPEED = 150.0

var aiming : bool = false

func _ready() -> void:
	#revolverPosition = revolver_sprite.position.x
	pass

func _process(delta: float) -> void:
	var mousePosition = get_global_mouse_position()
	if aiming:
		ray_1.look_at(mousePosition)
		if ray_1.is_colliding():
			var ray_1_direction = mousePosition - ray_1.global_position
			ray_1_direction = ray_1_direction.normalized()
			var normal = ray_1.get_collision_normal()
			ray_2.global_position = ray_1.get_collision_point()
			
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
		aiming = true
	elif event.is_action_released("MouseRight"):
		Engine.time_scale = 1.0
		aiming = false
	
