extends Area2D

@export var speed = 100
@export var range = 150

func _ready():
	$MuzzleFlashAnimation.hide()

func get_nearest_enemy():
	var nearest_robot = null
	var nearest_distance = 9999
	for robot in get_tree().get_nodes_in_group('robots'):
		var distance = global_position.distance_to(robot.global_position)
		if distance <= range and distance < nearest_distance:
			nearest_robot = robot
			nearest_distance = distance
			
	return nearest_robot

func _on_shoot_timer_timeout() -> void:
	var nearest = get_nearest_enemy()
	if nearest != null:
		nearest.take_damage(8)
		$MuzzleFlashAnimation.play('default')
		$MuzzleFlashAnimation.show()
	

func _on_muzzle_flash_animation_animation_finished() -> void:
	$MuzzleFlashAnimation.hide()
