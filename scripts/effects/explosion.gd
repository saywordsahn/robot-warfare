extends Node2D

@export var radius = 40
@export var damage = 15

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Use Targeting global to damage all enemies in a radius
	# you will have to make this method
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
