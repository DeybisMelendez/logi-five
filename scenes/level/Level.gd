extends Control
onready var engine = $VBoxContainer2/VBoxContainer/Engine
onready var Cells = $VBoxContainer2/VBoxContainer/Engine.get_children()
onready var Next = $MenuWin/VBoxContainer/Next
onready var Check = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Check
onready var Eraser = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Eraser
onready var Anim = $AnimationPlayer
onready var Pause = $VBoxContainer2/Panel/HBoxContainer3/Pause
onready var MenuPause = $MenuPause
onready var Resume = $MenuPause/VBoxContainer/Resume
onready var Diff = $VBoxContainer2/Panel/HBoxContainer3/Diff
onready var MenuWin = $MenuWin
onready var HomePause = $MenuPause/VBoxContainer/Menu
onready var HomeWin = $MenuWin/VBoxContainer/Menu

const HOME_PATH = "res://scenes/main/Main.tscn"

var level = Globals.actual_level
var max_level = Globals.user_data.max_level
var levels = Globals.user_data.levels
var diff = Globals.actual_difficulty
var data = {}

func _ready():
	config_level()
	Eraser.connect("button_up", self, "erase")
	Check.connect("button_up",self, "check_solution")
	Pause.connect("button_up", self, "pause")
	Resume.connect("button_up", self, "resume")
	Next.connect("button_up", self, "next")
	HomePause.connect("button_up", self, "go_home")
	HomeWin.connect("button_up", self, "go_home")

func next():
	Globals.actual_level += 1
	Background.reload()

func pause():
	Audio.play("Select")
	MenuPause.show()

func resume():
	Audio.play("Select")
	MenuPause.hide()

func go_home():
	Background.change_scene(HOME_PATH)

func erase():
	Audio.play("Wrong")
	engine.erase()
	save_actual_game()

func check_solution():
	if engine.check_solution():
		Audio.play("Win")
		MenuWin.show()
		if level == max_level:
			Globals.user_data.max_level +=1
			Globals.save_game()
	else:
		Anim.play("incorrect")
		Audio.play("Wrong")

func config_level():
	if level < 40:
		Globals.actual_difficulty = "Easy"
	elif level < 80:
		Globals.actual_difficulty = "Medium"
	else:
		Globals.actual_difficulty = "Hard"
	var new_seed = ("DeybisMelendez" + str(level)).hash()
	seed(new_seed)
	Diff.text = "Level " + str(level)
	if levels.size() > level:
		engine.generate_level(levels[level].user_solution)
	else:
		engine.generate_level("")

func save_actual_game():
	data.user_solution = engine.get_user_solution()
	if levels.size() > level:
		levels[level] = data
	else:
		levels.append(data)
	Globals.save_game()
