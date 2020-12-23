extends Control

onready var Cells = $VBoxContainer2/VBoxContainer/Cells.get_children()
onready var Home = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Home
onready var Check = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Check
onready var Eraser = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Eraser
onready var Clue = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Clue
onready var Solve = $VBoxContainer2/VBoxContainer/Panel/HBoxContainer/Solve
onready var YouWin = $VBoxContainer2/VBoxContainer/YouWin
onready var New = $VBoxContainer2/Panel/HBoxContainer3/New
onready var Anim = $AnimationPlayer
onready var Time = $VBoxContainer2/VBoxContainer/Time
onready var CountTime = $CountTime
onready var Pause = $MenuPause
onready var MenuPause = $MenuPause
onready var Resume = $MenuPause/VBoxContainer/Resume
onready var Diff = $VBoxContainer2/Panel/HBoxContainer3/Diff
onready var SolveText = $VBoxContainer2/VBoxContainer/Solve
const HOME_PATH = "res://scenes/main/Main.tscn"

#var solution = ""
var time = 0
var diff = Globals.actual_difficulty
var data = Globals.user_data.diff[diff]
var solve_mode = false

func _ready():
	config_level()
	Home.connect("button_up", self, "go_home")
	Eraser.connect("button_up", self, "erase")
	Check.connect("button_up",self, "check_solution")
	Clue.connect("button_up", self, "clue")
	New.connect("button_up", self, "reload")
	CountTime.connect("timeout", self, "timeout")
	Pause.connect("button_up", self, "pause")
	Resume.connect("button_up", self, "resume")

func pause():
	CountTime.stop()
	MenuPause.show()

func resume():
	CountTime.start()
	MenuPause.hide()

func timeout():
	time += 1
	Time.text = str(time)
	Globals.user_data.diff[diff].time = time
	Globals.save_game()

func clue():
	if Globals.user_data.clues > 0:
		SolveText.show()
		solve_mode = true

func solve_cell(cell):
	var i = Cells.find(cell)
	cell.solved(Globals.user_data.diff[diff].solution[i])
	Globals.user_data.clues -= 1
	update_clues()
	save_actual_game()
	SolveText.hide()
	solve_mode = false

func reload():
	reset_user_data()
	get_tree().reload_current_scene()

func go_home():
	get_tree().change_scene(HOME_PATH)

func erase():
	for cell in Cells:
		if cell.state == "editable":
			cell.set_number("")
	save_actual_game()

func reset_user_data():
	Globals.user_data.diff[diff].game = ""
	Globals.user_data.diff[diff].showed_cells = []
	Globals.user_data.diff[diff].time = 0
	Globals.user_data.diff[diff].level = -1

func check_solution():
	var user_solution = ""
	for cell in Cells:
		user_solution += cell.get_number()
	if Globals.user_data.diff[diff].solution == user_solution:
		for cell in Cells:
			if cell.state == "editable":
				cell.solved(cell.get_number())
		YouWin.show()
		Clue.hide()
		Solve.hide()
		Check.hide()
		Eraser.hide()
		reset_user_data()
		CountTime.stop()
		Globals.save_game()
		
	else:
		Anim.play("incorrect")

func config_level():
	Diff.text = Globals.actual_difficulty
	time = Globals.user_data.diff[diff].time
	Time.text = str(time)
	if Globals.user_data.diff[diff].level == -1:
		generate_level(randi()%Globals.levels.size())
	else:
		generate_level(Globals.user_data.diff[diff].level)
	update_clues()

func generate_level(l):
	Globals.user_data.diff[diff].level = l
	var level = Globals.levels[l]
	level = level.split(" ", false)
	var data = Globals.user_data.diff[diff]
	if data.game == "":
		var rots = randi()%5
		Globals.user_data.diff[diff].conf = rot(level[0], rots)
		Globals.user_data.diff[diff].solution = rot(level[1], rots)
		var conf = Globals.user_data.diff[diff].conf
		for index in conf.length():
			Cells[index].set_color(conf[index])
		var solved_cells = []
		var nums = 0
		match diff:
			"Hard":
				nums = 5+randi()%2
			"Medium":
				nums = 8+randi()%3
			"Easy":
				nums = 12+randi()%4
		for i in nums:
			var index = randi()%25
			while solved_cells.has(index):
				index = randi()%25
			solved_cells.append(index)
		data.solved_cells = solved_cells
		for i in solved_cells:
			Cells[i].solved(data.solution[i])
		save_actual_game()
	else:
		for index in data.conf.length():
			Cells[index].set_color(data.conf[index])
		for i in data.game.length():
			var num = data.game[i]
			if num == "-":
				num = ""
			if data.solved_cells.has(i):
				Cells[i].solved(num)
			else:
				Cells[i].set_number(num)

func update_clues():
	Clue.get_node("Label").text = str(Globals.user_data.clues)

func save_actual_game():
	var actual_conf = ""
	var showed_cells = []
	for i in Cells.size():
		var num = Cells[i].get_number()
		if num == "":
			num = "-"
		actual_conf += num
		if Cells[i].state == "solved":
			showed_cells.append(i)
	Globals.user_data.diff[diff].game = actual_conf
	Globals.user_data.diff[diff].showed_cells = showed_cells
	Globals.user_data.diff[diff].time = time
	Globals.save_game()

func rot(s, times):
	if times == 0:
		return s
	var result = ""
	var columns = [0,1,2,3,4]
	for _i in times:
		for i in columns:
			for j in 5:
				result += s[i+j*5]
		s = result + ""
		result = ""
	return s
