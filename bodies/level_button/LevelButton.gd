extends TextureButton

var level = 1
const LEVEL_PATH = "res://scenes/level/Level.tscn"

func _ready():
	connect("button_up", self, "pressed")

func lock():
	disabled = true
	$Label.text = ""

func set_level(lvl):
	disabled = false
	level = lvl
	$Label.text = str(lvl)

func pressed():
	Globals.actual_level = level
	Background.change_scene(LEVEL_PATH)
