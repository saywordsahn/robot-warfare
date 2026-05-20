extends Area2D

@export var speed = 100
@export var range = 150
@export var cooldown = 1.0
@export var damage = 3


func _ready():
	$ShootTimer.wait_time = cooldown
	$MuzzleFlashAnimation.hide()

func _on_shoot_timer_timeout() -> void:
	var nearest = Targeting.get_nearest_enemy(global_position, range)
	if nearest != null:
		nearest.take_damage(damage)
		$MuzzleFlashAnimation.play('default')
		$MuzzleFlashAnimation.show()
	

func _on_muzzle_flash_animation_animation_finished() -> void:
	$MuzzleFlashAnimation.hide()
