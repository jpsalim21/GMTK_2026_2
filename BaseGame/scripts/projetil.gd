extends Area2D

@export var speed : float
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var normal : Vector2
var direction : Vector2

func _ready() -> void:
	body_entered.connect(collision_entered)
	#set_process(false)
	setup(Vector2(1, 0))

func setup(_direction : Vector2):
	direction = _direction
	ray_cast_2d.target_position = direction * 50
	set_process(true)

func _physics_process(delta: float) -> void:
	global_position += direction * speed
	normal = ray_cast_2d.get_collision_normal()

func collision_entered(node : Node2D):
	direction = normal
	ray_cast_2d.target_position = direction * 50
