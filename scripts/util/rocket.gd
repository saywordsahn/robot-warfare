extends Area2D

const EXPLOSION = preload("uid://cis2jjimk16b")

@export var speed = 100.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('robots'):
		SoundManagerAdvanced.play('explosion')
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
