extends Area2D

@export var level: String
var player = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if player != null:
			if Global.enemy_count <= 0 and player.in_next_level_area:
				get_tree().change_scene_to_file("res://scenes/" + level +".tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player1":
		player = body
		body.in_next_level_area = true
			
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player1":
		player = body
		body.in_next_level_area = false
