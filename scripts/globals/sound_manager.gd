extends Node

var sounds = {
	"gunshot": preload("res://sounds/effects/gunshot.mp3"),
	"ui-select": preload("res://sounds/ui/button-click.wav")
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

func play_music(track):
	music_player.stream = load(track)
	music_player.play()

func stop_music():
	music_player.stop()
