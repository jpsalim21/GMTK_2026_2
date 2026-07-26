class_name Bullet
extends Area2D

@export var speed : float = 7
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var normal : Vector2
var direction : Vector2

var bounce_count : int = 4

func _ready() -> void:
	body_entered.connect(collision_entered)

func setup(_direction : Vector2):
	direction = _direction
	ray_cast_2d.target_position = direction * 50
	set_process(true)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	normal = ray_cast_2d.get_collision_normal()

func collision_entered(node : Node2D):
	if normal == Vector2.ZERO:
		return
	bounce_count -= 1
	if bounce_count <= 0:
		queue_free()
		return
	direction = -direction.reflect(normal)
	ray_cast_2d.target_position = direction * 50

func _draw() -> void:
	draw_circle(Vector2.ZERO, 3, Color.ORANGE_RED, true)
