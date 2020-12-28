extends Control
onready var engine = $VBoxContainer2/VBoxContainer/Engine
onready var Cells = $VBoxContainer2/VBoxContainer/Engine.get_children()
onready var Check = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Check
onready var Eraser = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Eraser
onready var New = $VBoxContainer2/Panel/HBoxContainer3/New
onready var Anim = $AnimationPlayer
onready var Time = $VBoxContainer2/VBoxContainer/Time
onready var CountTime = $CountTime
onready var Pause = $VBoxContainer2/Panel/HBoxContainer3/Pause
onready var MenuPause = $MenuPause
onready var Resume = $MenuPause/VBoxContainer/Resume
onready var Diff = $VBoxContainer2/Panel/HBoxContainer3/Diff
onready var MenuWin = $MenuWin
onready var Best = $MenuWin/VBoxContainer/HBoxContainer/Best
onready var TimeWin = $MenuWin/VBoxContainer/HBoxContainer2/TimeWin
onready var NewRecord = $MenuWin/VBoxContainer/HBoxContainer/NewRecord
onready var NewGame = $MenuWin/VBoxContainer/NewGame
onready var HomePause = $MenuPause/VBoxContainer/Menu
onready var HomeWin = $MenuWin/VBoxContainer/Menu

const HOME_PATH = "res://scenes/main/Main.tscn"

var time = 0
var diff = Globals.actual_difficulty
var data = Globals.user_data.diff[diff]
var stats = Globals.stats.diff[diff]

func _ready():
	config_level()
	Eraser.connect("button_up", self, "erase")
	Check.connect("button_up",self, "check_solution")
	New.connect("button_up", self, "reload")
	CountTime.connect("timeout", self, "timeout")
	Pause.connect("button_up", self, "pause")
	Resume.connect("button_up", self, "resume")
	NewGame.connect("button_up", self, "reload")
	HomePause.connect("button_up", self, "go_home")
	HomeWin.connect("button_up", self, "go_home")

func pause():
	Audio.play("Select")
	CountTime.stop()
	MenuPause.show()

func resume():
	Audio.play("Select")
	CountTime.start()
	MenuPause.hide()

func timeout():
	time += 1
	update_time()
	Globals.save_game()

func update_time():
	Time.text = str(time)
	data.time = time

func reload():
	reset_user_data()
	Background.reload()

func go_home():
	Background.change_scene(HOME_PATH)

func erase():
	Audio.play("Wrong")
	engine.erase()
	save_actual_game()

func reset_user_data():
	data.time = 0
	data.level_seed = -1
	data.use_solution = ""
	save_actual_game()

func check_solution():
	if engine.check_solution():
		Audio.play("Select")
		reset_user_data()
		CountTime.stop()
		Globals.save_game()
		MenuWin.show()
		if check_best_time():
			Audio.play("NewRecord")
			Best.text = str(time)
			NewRecord.show()
			stats.best = time
		else:
			Audio.play("Win")
			Best.text = str(get_best_time())
		TimeWin.text = str(time)
		stats.history.append(time)
		Globals.save_stats()
	else:
		Anim.play("incorrect")
		Audio.play("Wrong")

func get_best_time():
	var best = 10000000
	for before in stats.history:
		if before < best:
			best = before
	return best

func check_best_time():
	for before in stats.history:
		if before < time:
			return false
	return true

func config_level():
	Diff.text = Globals.actual_difficulty
	if data.level_seed == -1:
		data.level_seed = new_seed()
		engine.generate_level("")
		Globals.save_game()
	else:
		seed(data.level_seed)
		engine.generate_level(data.user_solution)
		time = data.time
	update_time()

func new_seed():
	randomize()
	var random_seed = randi()
	seed(random_seed)
	return random_seed

func save_actual_game():
	data.user_solution = engine.get_user_solution()
	data.time = time
	Globals.save_game()
