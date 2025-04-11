extends Node2D

var player = null;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if player != null:
			if player.in_item_area:
				get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player1":
		player = body
		body.in_item_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player1":
		body.in_item_area = false
