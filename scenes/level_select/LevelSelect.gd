extends Control

var button = preload("res://bodies/level_button/LevelButton.tscn")
onready var buttons = $VBoxContainer/GridContainer.get_children()
onready var LeftButton = $VBoxContainer/HBoxContainer/LeftButton
onready var RightButton = $VBoxContainer/HBoxContainer/RightButton
onready var world = $VBoxContainer/HBoxContainer/World
onready var home = $VBoxContainer/Panel/HBoxContainer/Home
const MAIN_PATH = "res://scenes/main/Main.tscn"

var index = 0
var max_level = Globals.user_data.max_level

func _ready():
	set_buttons()
	LeftButton.connect("button_up", self, "left")
	RightButton.connect("button_up", self, "right")
	home.connect("button_up", self, "home")

func home():
	Background.change_scene(MAIN_PATH)

func left():
	index -= 1
	if index < 0:
		index = 2
	update_buttons()

func update_buttons():
	world.text = str(index+1)
	set_buttons()

func right():
	index += 1
	if index > 2:
		index = 0
	update_buttons()

func set_buttons():
	for i in buttons.size():
		var button = buttons[i]
		var level = i+1 + index*40
		if level > max_level:
			button.lock()
		else:
			button.set_level(level)
