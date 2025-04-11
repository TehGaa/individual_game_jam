extends Node2D

@onready var player = $Player1
@onready var healthBar = $CanvasLayer/HealthBar
@onready var closedDoor = $TileMapLayer/TileMapLayer2/ClosedDoor
@onready var openedDoor = $TileMapLayer/TileMapLayer2/OpenedDoor
@export var enemyCount = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthBar.value = player.health
	Global.enemy_count = enemyCount
	openedDoor.visible = false
	Global.level = name
	
	if name != "Level3":
		MusicManager.play_music(preload("res://assets/background_music/raya_lucaria_cut.wav"), "level")
	else:
		MusicManager.play_music(preload("res://assets/background_music/boss_fight_cut.wav"), "boss")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthBar.value = player.health
	if Global.enemy_count <= 0:
		closedDoor.visible = false
		openedDoor.visible = true
		
		if (name == "Level3"):
			player.legendSlain.visible = true
