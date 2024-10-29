extends Node2D

@onready var introText = $bg/intro_text
@onready var white = $bg/white
@onready var secretVideo = $bg/secretVideo
@onready var skipText = $bg/skipLabel

var curSection:int = 1
var part:int = 0
var daTimer:float = 0

var save_path = "user://settings.json"

var holdTimer = 2

var randomShit:Array = [
	"Hi guys, how you doing?",
	"No sunlight. Norway moment",
	"I'm tired, give me a break",
	"I always wanted to make a grass joke\nApparently",
	"Check out my YouTube. please",
	"How do I make this rated E?",
	"TURN ON THE HEATERS IAN!",
	"Tabu got so scared he turned into human",
	"STOP TRYING TO KILL THE CHILD",
	"kristharshdifficulty%",
	"Archen is cute, change my mind",
	"Uncaught error: Null Object Reference",
	"null was killed by null",
	"Ray0",
	"Remember when you can't check who's alive?",
	"Protect, Explore, Repeat",
	"I don't know what a clone block is",
	"Read the FALLMON wiki for information",
	"What can a broken tail do?",
	"AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH",
	"Krist is a Breloom\nand he's a pacifist. Deal with it",
	"Sheila tried to catch the RPG before it hit\nthe ground and fired\n\n\n(Which killed Krist)",
	"How many jokes related to Krist I'm going to make?",
	"FALLMON is a horror game but doesn't have jumpscares",
	]

var rng = RandomNumberGenerator.new()
@onready var my_random_number = floor(rng.randf_range(0, 40))

func _ready():
	loadSettings()
	introText.modulate.a = 0
	introText.text = 'Created by\nClassic1926'
	white.modulate.a = 0
	
	print(my_random_number)
	
	skipText.modulate.a = 0
	
	if (my_random_number == 37):
		secretVideo.play()
		daTimer = 56

func loadSettings():
	if FileAccess.file_exists(save_path):
		pass
	else:
		print('no settings file found, making a new one')
		resetSettings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	daTimer -= 1 * delta
	#print(floor(daTimer))
	
	if Input.is_action_pressed("escape"):
		holdTimer -= 1 * delta
		if (skipText.modulate.a < 1):
				skipText.modulate.a += 2 * delta
		
		if holdTimer < 0 or OS.is_debug_build():
			get_tree().change_scene_to_file("res://scenes/menus/title.tscn")
	else:
		holdTimer = 2
		if (skipText.modulate.a > 0):
				skipText.modulate.a -= 2 * delta
	
	if (daTimer < 0):
		part += 1
		print(part)
		nextPart()
	
	match part:
		1,3,5:
			if (introText.modulate.a < 1):
				introText.modulate.a += 1 * delta
		2,4,6:
			if (introText.modulate.a > 0):
				introText.modulate.a -= 1 * delta
		7:
			if (white.modulate.a < 1):
				white.modulate.a += 1 * delta


func nextPart():
	if my_random_number == 37:
		part = 8
	
	match part:
		1:
			daTimer = 3
		2,4,6,7:
			daTimer = 1
		3:
			daTimer = 3
			introText.text = 'Contributed by\nDS Dude\nTheMinorStar\n0PizzaPasta0'
		5:
			introText.text = randomShit.pick_random()
			daTimer = 3
		8:
			secretVideo.stop()
			get_tree().change_scene_to_file("res://scenes/menus/title.tscn")

func resetSettings():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	var saved_data = {}
	
	saved_data["shaders"] = true
	saved_data["overlay"] = true
	saved_data["smooth-filter"] = false
	
	var json = JSON.stringify(saved_data)
	
	file.store_string(json)
	file.close()
