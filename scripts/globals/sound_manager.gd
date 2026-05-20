extends Node

var sounds = {
	"gunshot": preload("res://sounds/effects/gunshot.mp3"),
	"ui-select": preload("res://sounds/ui/button-click.wav"),
	"lose": preload("res://sounds/effects/lose.wav"),
	"machine-gun": preload("res://sounds/effects/machine-gun-burst.mp3")
}

var music = {
	"title": preload("res://sounds/music/montogoronto.mp3")
}

var sfx_player
var music_player

func _ready():
	sfx_player = AudioStreamPlayer.new()
	music_player = AudioStreamPlayer.new()

	add_child(sfx_player)
	add_child(music_player)

func play(sound_name):
	if sounds.has(sound_name):
		sfx_player.stream = sounds[sound_name]
		sfx_player.play()

func play_music(track_name):
	music_player.stream = music[track_name]
	music_player.play()

func stop_music():
	music_player.stop()
