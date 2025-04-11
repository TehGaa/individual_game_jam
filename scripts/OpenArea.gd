extends Area2D


@onready var unlockedDoor = $UnlockedDoor
@onready var lockedDoor = $LockedDoor

var player = null

func _ready() -> void:
	unlockedDoor.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if player != null:
			if player.in_locked_area:
				if lockedDoor.visible:
					lockedDoor.collision_enabled = false
					lockedDoor.visible = false
					unlockedDoor.visible = true
				else:
					lockedDoor.collision_enabled = true
					lockedDoor.visible = true
					unlockedDoor.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player1":
		player = body
		player.in_locked_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player1":
		player = body
		player.in_locked_area = false
