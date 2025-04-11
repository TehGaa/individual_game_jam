extends Control

var canContinue = false
@onready var label3 = $MarginContainer/ColorRect/VBoxContainer/Label3

func _ready():
	label3.visible = false
	$Continue.start(2)

func _input(event: InputEvent) -> void:
	if canContinue:
		if event is InputEventKey:
			get_tree().change_scene_to_file("res://scenes/Level1.tscn")
		elif event is InputEventMouseButton:
			get_tree().change_scene_to_file("res://scenes/Level1.tscn")



func _on_continue_timeout() -> void:
	canContinue = true
	label3.visible = true
