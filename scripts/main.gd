extends Node2D

const SCARAB = preload("uid://bdlenhbuyuu13")
const SMALL_FRAGMENTS = preload("uid://cua5yx7i2fthw")
const DAMAGE_NUMBERS = preload("uid://cavvx4krfmcvh")


var money = 0
var health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed('pause'):
		$UI/PauseMenu.show()
		get_tree().paused = true
	
	
	if Input.is_action_just_pressed('pan_left'):
		create_tween()\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)\
			.tween_property(
				$Camera2D,
				"position",
				$Camera2D.position + Vector2.LEFT * 250,
				0.5
			)
	
	if Input.is_action_just_pressed('pan_right'):
		create_tween()\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)\
			.tween_property(
				$Camera2D,
				"position",
				$Camera2D.position + Vector2.RIGHT * 250,
				0.5
			)
	
	if Input.is_action_just_pressed("main_weapon"):
		# create small fragments
		SoundManager.play("gunshot")
		var fragments = SMALL_FRAGMENTS.instantiate()
		fragments.global_position = get_global_mouse_position()
		add_child(fragments)


func _on_enemy_killed():
	money += 10
	$UI/MoneyLabel.text = '$ ' + str(money)

func _on_scarab_spawn_timer_timeout() -> void:
	var scarab = SCARAB.instantiate()
	scarab.position.x = 350
	scarab.position.y = randi_range(15, 170)
	scarab.on_killed.connect(_on_enemy_killed)
	scarab.on_base_reached.connect(base_reached)
	scarab.on_attacked.connect(add_damage_nums)
	# add_child adds the instance (scarab) as 
	# a child of the node that the script is on
	add_child(scarab)

func add_damage_nums(amount, position):
	var damage_numbers = DAMAGE_NUMBERS.instantiate()
	damage_numbers.global_position = position
	damage_numbers.set_amount(amount)
	add_child(damage_numbers)

func base_reached():
	$UI/GameOverLabel.show()
	$UI/ReturnToMainButton.show()


func _on_round_timer_timeout() -> void:
	$ScarabSpawnTimer.wait_time *= .9	


func _on_return_to_main_button_pressed() -> void:
	SoundManager.play('ui-select')
	get_tree().change_scene_to_file("res://scenes/title.tscn")


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	$UI/PauseMenu.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title.tscn")
