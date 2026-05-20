extends Area2D
signal on_killed
signal on_base_reached
signal on_attacked(amount: int, position)

@export var speed = 30
@export var max_health: int = 14
var health = max_health

var alive = true

func take_damage(amount: int):
	health -= amount
	
	on_attacked.emit(amount, global_position)
	
	if health <= 0:
		$AnimatedSprite2D.play('die')
		on_killed.emit()
		remove_from_group("robots")
		alive = false
		set_process(false)
		
	if global_position.x < 0:
		on_base_reached.emit()

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if alive and event is InputEventMouseButton and event.pressed:
		take_damage(7)

func _process(delta: float) -> void:
	position.x -= speed * delta
