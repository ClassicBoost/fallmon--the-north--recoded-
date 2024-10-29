extends Control

@export var difficulty = 'normal'
@onready var diff_text = $diff_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	diff_text.text = 'DIFFICULTY SELECTED: ' + difficulty.to_upper() + '\n\n'
	diff_text.set("theme_override_colors/font_color", 0xFFFFFFFF)
	
	match difficulty:
		'normal':
			diff_text.text += 'Start with full supplies, sickness is reduced,\nand less fails.'
		'hard':
			diff_text.text += 'Start with reduced supplies, everything else\nis moderate.'
		'harsh':
			diff_text.text += 'Start with low supplies. The land is hell.'
			diff_text.set("theme_override_colors/font_color", 0xFF6B77FF)


func diff_selected(diff):
	difficulty = diff

func start_game():
	get_tree().change_scene_to_file("res://scenes/game/starting_cutscene.tscn")
