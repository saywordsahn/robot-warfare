extends Node

# =========================
# SOUND DATABASES
# =========================

var sounds = {
	"gunshot": preload("res://sounds/effects/gunshot.mp3"),
	"ui-select": preload("res://sounds/ui/button-click.wav"),
	"lose": preload("res://sounds/effects/lose.wav"),
	"machine-gun-burst": preload("res://sounds/effects/machine-gun-burst.mp3"),
	"machine-gun-shot": preload("res://sounds/effects/machine-gun-shot.wav"),
	"explosion": preload("uid://dn74w40w5r83e")
}

var music = {
	"title": preload("res://sounds/music/montogoronto.mp3")
}

# =========================
# MUSIC PLAYER
# =========================

var music_player : AudioStreamPlayer

# =========================
# SETUP
# =========================

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	music_player.bus = "Music"

# =========================
# SOUND EFFECTS
# =========================

func play(sound_name : String, volume := 0.0, pitch := 1.0):
	if not sounds.has(sound_name):
		print("Sound not found: ", sound_name)
		return

	var player = AudioStreamPlayer.new()

	add_child(player)

	player.stream = sounds[sound_name]

	player.volume_db = volume
	player.pitch_scale = pitch

	player.bus = "SFX"

	player.finished.connect(player.queue_free)

	player.play()

# =========================
# RANDOMIZED SFX
# =========================

func play_random_pitch(sound_name : String):
	play(
		sound_name,
		0.0,
		randf_range(0.9, 1.1)
	)

# =========================
# MUSIC
# =========================

func play_music(track_name : String):
	if not music.has(track_name):
		print("Music not found: ", track_name)
		return

	if music_player.stream == music[track_name]:
		return

	music_player.stream = music[track_name]
	music_player.play()

func stop_music():
	music_player.stop()

# =========================
# OPTIONAL HELPERS
# =========================

func has_sound(sound_name):
	return sounds.has(sound_name)

func has_music(track_name):
	return music.has(track_name)
