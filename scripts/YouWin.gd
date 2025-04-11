extends Control


func _on_change_scene_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
