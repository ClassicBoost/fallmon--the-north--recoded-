extends Node2D

@onready var start_menu = $start_menu
@onready var buttonShit = $dumb
@onready var white = $white
var inSubMenu = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not inSubMenu:
		start_menu.hide()
		buttonShit.show()
	
	if Input.is_action_pressed("escape"):
		inSubMenu = false
	
	if (white.modulate.a > 0):
		white.modulate.a -= 1 * delta


func option_pressed(option):
	match option:
		'start':
			inSubMenu = true
			start_menu.show()
			buttonShit.hide()
		'settings':
			pass
		'awards':
			pass
		'quit':
			get_tree().quit()
