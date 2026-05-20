extends Area2D

const ROCKET = preload("uid://hbhl1ksinmd")


@export var speed = 100
@export var range = 150
@export var cooldown = 6.0

func _ready():
	$ShootTimer.wait_time = cooldown

func _on_shoot_timer_timeout() -> void:
	var rocket = ROCKET.instantiate()
	rocket.global_position = global_position
	get_parent().add_child(rocket)
