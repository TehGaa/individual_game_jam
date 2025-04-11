extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = false
var max_health = 100
var health = 100
var player_alive = true

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_jumping = false
var attack_progress = false
var current_dir = "right"

var in_next_level_area = false
var in_item_area = false
var in_locked_area = false

@onready var youDied = $YouDied
@onready var legendSlain = $LegendSlain

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	youDied.visible = false
	legendSlain.visible = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("ui_left", "ui_right")
	
	enemy_attack()

	if player_alive == false:
		if $DeathAnimation.is_stopped():
			$DeathAnimation.start(5)
		
	elif health <= 0:
		player_alive = false
		$AnimatedSprite2D.play("dead")
		$DeathProgressAnimation.start(1)
	else:
		if is_on_floor():
			attack()
			if direction:
				if direction > 0:
					current_dir = "right"
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("walk")
				if direction < 0:
					current_dir = "left"
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("walk")
				velocity.x = direction * SPEED
			else:
				if attack_progress == false:
					$AnimatedSprite2D.play("idle")
				velocity.x = move_toward(velocity.x, 0, SPEED)
			
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = JUMP_VELOCITY
				is_jumping = true
		else:
			if is_jumping:
				$AnimatedSprite2D.play("jump")
				velocity.x = direction * SPEED
			else: 
				$AnimatedSprite2D.play("idle")
		
		move_and_slide()

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func player():
	pass
	
func enemy_attack():
	if (enemy_inattack_range) and (enemy_attack_cooldown == false):
		enemy_attack_cooldown = true
		health -= Global.enemy_damage
		$AttackCooldown.start(3)


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = false

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_progress = true
		
		$AnimatedSprite2D.play("attack")
		$DealAttack.start()


func _on_deal_attack_timeout() -> void:
	$DealAttack.stop()
	Global.player_current_attack = false
	attack_progress = false
	

func _on_death_progress_animation_timeout() -> void:
	$YouDied.visible = true
	$AnimatedSprite2D.play("dead_idle")	

func _on_death_animation_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
