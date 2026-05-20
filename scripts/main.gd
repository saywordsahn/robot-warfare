extends Node2D

const SCARAB = preload("uid://bdlenhbuyuu13")
const SMALL_FRAGMENTS = preload("uid://cua5yx7i2fthw")
const DAMAGE_NUMBERS = preload("uid://cavvx4krfmcvh")
const SOLDIER = preload("uid://6qns4wkoe8hd")
const SNIPER = preload("uid://cjcjlt0nrdoos")
const MACHINE_GUNNER = preload("uid://ct65jnvyqy30o")
const ANTI_TANK = preload("uid://p3a52meojdv1")
const SPIDER = preload("uid://xd3d3sp4ybyi")

@export var starting_money = 1000
@export var soldier_cost: int = 100
@export var sniper_cost: int = 500
@export var anti_tank_cost: int = 1000
@export var machine_gunner_cost: int = 300

var round = 1
var game_over = false
var money = starting_money

var selected_object = 1

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
		
	if Input.is_action_just_pressed("place_soldier"):
		if selected_object == 1 and money >= soldier_cost:
			money -= soldier_cost
			var soldier = SOLDIER.instantiate()
			soldier.global_position = get_global_mouse_position()
			add_child(soldier)
		elif selected_object == 2 and money >= sniper_cost:
			money -= sniper_cost
			var soldier = SNIPER.instantiate()
			soldier.global_position = get_global_mouse_position()
			add_child(soldier)
		elif selected_object == 3 and money >= machine_gunner_cost:
			money -= machine_gunner_cost
			var soldier = MACHINE_GUNNER.instantiate()
			soldier.global_position = get_global_mouse_position()
			add_child(soldier)
		elif selected_object == 4 and money >= anti_tank_cost:
			money -= anti_tank_cost
			var soldier = ANTI_TANK.instantiate()
			soldier.global_position = get_global_mouse_position()
			add_child(soldier)
		
		$UI/MoneyLabel.text = '$ ' + str(money)
		
	if Input.is_action_just_pressed("slot_1"):
		selected_object = 1
		$UI/SelectedObjectLabel.text = 'Right-Click: Assualt'
	elif Input.is_action_just_pressed("slot_2"):
		selected_object = 2
		$UI/SelectedObjectLabel.text = 'Right-Click: Sniper'
	elif Input.is_action_just_pressed("slot_3"):
		selected_object = 3
		$UI/SelectedObjectLabel.text = 'Right-Click: Machine Gunner'
	elif Input.is_action_just_pressed("slot_4"):
		selected_object = 4
		$UI/SelectedObjectLabel.text = 'Right-Click: Anti-Tank'


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

func _on_spider_spawn_timer_timeout() -> void:
	var spider = SPIDER.instantiate()
	spider.position.x = 350
	spider.position.y = randi_range(15, 170)
	spider.on_killed.connect(_on_enemy_killed)
	spider.on_base_reached.connect(base_reached)
	spider.on_attacked.connect(add_damage_nums)
	# add_child adds the instance (scarab) as 
	# a child of the node that the script is on
	add_child(spider)

func add_damage_nums(amount, position):
	var damage_numbers = DAMAGE_NUMBERS.instantiate()
	damage_numbers.global_position = position
	damage_numbers.set_amount(amount)
	add_child(damage_numbers)

func base_reached():
	if game_over == false:
		$RoundTimer.stop()
		game_over = true
		SoundManager.play("lose")
		$UI/GameOverLabel.show()
		$UI/ReturnToMainButton.show()

func _on_round_timer_timeout() -> void:
	round += 1
	$UI/RoundLabel.text = 'Round ' + str(round)
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
