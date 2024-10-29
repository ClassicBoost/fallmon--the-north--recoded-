extends Node2D

@onready var diff = $start_menu

@export var game_difficulty = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	game_difficulty = diff.difficulty
	print(game_difficulty)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
