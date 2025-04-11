extends Control

func _ready() -> void:
	Global.level = "MainMenu"
	MusicManager.play_music(preload("res://assets/background_music/boss_fight_cut.wav"))
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://scenes/Level1.tscn")
	elif event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://scenes/Level1.tscn")
	
