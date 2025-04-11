extends Control

func _ready() -> void:
	Global.level = "MainMenu"
	Global.character_damage = 20
	MusicManager.play_music(preload("res://assets/background_music/boss_fight_cut.wav"))
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://scenes/DialogScene.tscn")
	elif event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://scenes/DialogScene.tscn")
	
