extends Area2D

@export var speed = 100
@export var range = 150
@export var cooldown = 1.0
@export var damage = 3


func _ready():
	$ShootTimer.wait_time = cooldown
	$MuzzleFlashAnimation.hide()

func _on_shoot_timer_timeout() -> void:
	var nearest = Targeting.get_random_enemy(global_position, range)
	if nearest != null:
		SoundManagerAdvanced.play('machine-gun-shot', -4.0, randf_range(-3, 2))
		nearest.take_damage(damage)
		$MuzzleFlashAnimation.play('default')
		$MuzzleFlashAnimation.show()
	

func _on_muzzle_flash_animation_animation_finished() -> void:
	$MuzzleFlashAnimation.hide()
