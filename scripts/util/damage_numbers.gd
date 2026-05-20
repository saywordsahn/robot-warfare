extends Label

@export var speed = 70.0
@export var fade_out_speed = 2.0

func set_amount(amount: int):
	text = str(amount)

func _process(delta: float) -> void:
	position.y -= delta * speed
	modulate.a -= delta * fade_out_speed


func _on_timer_timeout() -> void:
	queue_free()
