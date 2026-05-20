extends Node2D

func _ready():
	SoundManager.play_music('title')

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	SoundManager.stop_music()
	SoundManager.play('ui-select')
	get_tree().change_scene_to_file("res://scenes/main.tscn")
