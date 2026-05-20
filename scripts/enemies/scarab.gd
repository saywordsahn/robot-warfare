extends Area2D
signal on_killed
signal on_base_reached
signal on_attacked(amount: int, position)

@export var speed = 30
@export var max_health: int = 14

var health
var alive = true

func _ready():
	health = max_health

func take_damage(amount: int):
	health -= amount
	
	on_attacked.emit(amount, global_position)
	
	if health <= 0:
		$AnimatedSprite2D.play('die')
		on_killed.emit()
		remove_from_group("robots")
		alive = false
		set_process(false)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if alive and Input.is_action_just_pressed("main_weapon"):
		take_damage(7)

func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if global_position.x < 0:
		on_base_reached.emit()
