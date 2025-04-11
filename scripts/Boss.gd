extends CharacterBody2D

@export var speed = 50
@export var itemScene: PackedScene
@onready var healthBar = $HealthBar

var playerChase =  false
var player = null

var health = 500
var player_inattack_zone = false
var can_take_damage = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	

func _physics_process(delta: float) -> void:
	damage()
	healthBar.value = health
	if is_on_floor():
		if health <= 0:
			$AnimatedSprite2D.play("dead")	
		elif player_inattack_zone:
			if (player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack")
		elif playerChase:
			position += (player.position - position)/speed
			$AnimatedSprite2D.play("walk")
			if (player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play('idle')
	else:
		velocity.y += gravity * delta
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	if speed > 0:
		playerChase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	playerChase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
		
func damage():
	if player_inattack_zone and Global.player_current_attack:
		if can_take_damage == true:
			health -= Global.character_damage
			$TakeDamageCooldown.start()
			can_take_damage = false
			if health <= 0:
				Global.enemy_count -= 1
				playerChase = false
				$DeathAnimation.start(0.5)

func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	

func _on_death_animation_timeout() -> void:
	player.health += 20
	
	drop_item()
	self.queue_free()

func drop_item():
	var itemInstance = itemScene.instantiate()
	itemInstance.position = position
	itemInstance.position.y += 50
	get_parent().add_child(itemInstance)
