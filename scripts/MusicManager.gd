extends Node2D

var music_player: AudioStreamPlayer
var curLevel = "MainMenu"

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"
	play_music(preload("res://assets/background_music/boss_fight_cut.wav"), "start")

func play_music(music_stream: AudioStream, level = "MainMenu"):
	if curLevel != level:
		curLevel = level
		if music_player.playing:
			music_player.stop()
		music_player.stream = music_stream
		music_player.volume_db = -5
		music_player.play()
