extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var revolver_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_1: RayCast2D = $Raycasts/Ray1
@onready var ray_2: RayCast2D = $Raycasts/Ray2
@onready var aim_line: Line2D = $Raycasts/Line2D

@export var count_down_interface : CountDownInterface

const PROJETIL = preload("uid://di82e63mcqs6j")

var revolverPosition: float 
const SPEED = 150.0

var aiming : bool = false
var aim_direction : Vector2

var bullets_left := 6

func _ready() -> void:
	revolverPosition = revolver_sprite.position.x
	GameManager.time_scale_changed.connect( time_scale_change )
	pass

func _process(delta: float) -> void:
	var mousePosition = get_global_mouse_position()
	aim_direction = mousePosition - ray_1.global_position
	if aiming:
		ray_1.look_at(mousePosition)
		aim_direction = aim_direction.normalized()
		aim_line.visible = true
		aim_line.position = aim_direction * (revolver_sprite.offset.x + 6)
		if ray_1.is_colliding():
			var normal = ray_1.get_collision_normal()
			var ray1_pos = ray_1.get_collision_point()
			var reflected = aim_direction.bounce(normal)
			ray_2.global_position = ray_1.get_collision_point()
			ray_2.look_at( ray_2.global_position + reflected)
			
			aim_line.set_point_position(1, ray1_pos - aim_line.global_position)
			aim_line.set_point_position(2, ray_2.global_position + reflected * 500 - aim_line.global_position)
		else:
			aim_line.set_point_position(1, aim_direction * 500)
			aim_line.set_point_position(2, aim_direction * 500)
	else:
		aim_line.visible = false
	
	if global_position.x < mousePosition.x:
		revolver_sprite.flip_v = false
		revolver_sprite.position.x = revolverPosition
		player_sprite.flip_h = false
	else:
		revolver_sprite.position.x = - revolverPosition
		revolver_sprite.flip_v = true
		player_sprite.flip_h = true
	
	
	revolver_sprite.look_at(mousePosition)
	if Input.is_action_just_pressed("MouseLeft"):
		shoot()

func shoot() -> void:
	if bullets_left <= 0:
		return
	bullets_left -= 1
	var bullet : Bullet = PROJETIL.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.setup(aim_direction.normalized())
	bullet.global_position = global_position
	
	revolver_sprite.play("shoot")
	count_down_interface.run_down_animation(bullets_left)
	await revolver_sprite.animation_finished
	revolver_sprite.play("idle")

func time_scale_change(new_value : float):
	revolver_sprite.speed_scale = 1.0 / new_value


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	if direction.x == 0 && direction.y == 0:
		player_sprite.play("idle")
	else:
		player_sprite.play("walking")
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseRight"):
		GameManager.time_scale = 0.1
		aiming = true
	elif event.is_action_released("MouseRight"):
		GameManager.time_scale = 1.0
		aiming = false
	
