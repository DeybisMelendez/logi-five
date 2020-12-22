extends Control

onready var Cells = $VBoxContainer/Cells.get_children()
onready var Level = $VBoxContainer/HBoxContainer2/Level
onready var Home = $VBoxContainer/Panel/HBoxContainer/Home
onready var Check = $VBoxContainer/Panel/HBoxContainer/Check
onready var Eraser = $VBoxContainer/Panel/HBoxContainer/Eraser
onready var Clue = $VBoxContainer/Panel/HBoxContainer/Clue
onready var Solve = $VBoxContainer/Panel/HBoxContainer/Solve
onready var YouWin = $VBoxContainer/YouWin
onready var Next = $VBoxContainer/Panel/HBoxContainer/Next
onready var Anim = $AnimationPlayer

const HOME_PATH = "res://scenes/main/Main.tscn"
var solution = ""

func _ready():
	config_level()
	Home.connect("button_up", self, "go_home")
	Eraser.connect("button_up", self, "erase")
	Check.connect("button_up",self, "check_solution")
	Clue.connect("button_up", self, "clue")
	Next.connect("button_up", self, "next")

func clue():
	var cells_free = []
	for cell in Cells:
		if cell.state == "editable":
			cells_free.append(cell)
	if cells_free.size() > 0:
		var rand = randi()%cells_free.size()
		var i = Cells.find(cells_free[rand])
		cells_free[rand].solved(solution[i])
		Globals.user_data.clues -= 1
		save_actual_game()
		update_clues()

func next():
	get_tree().reload_current_scene()

func go_home():
	get_tree().change_scene(HOME_PATH)

func erase():
	for cell in Cells:
		if cell.state == "editable":
			cell.set_number("")
	save_actual_game()

func check_solution():
	var user_solution = ""
	for cell in Cells:
		user_solution += cell.get_number()
	if solution == user_solution:
		for cell in Cells:
			if cell.state == "editable":
				cell.solved(cell.get_number())
		YouWin.show()
		Next.show()
		Clue.hide()
		Solve.hide()
		Check.hide()
		Eraser.hide()
		Globals.user_data.level += 1
		Globals.user_data.game = ""
		Globals.user_data.showed_cells = []
		Globals.save_game()
	else:
		Anim.play("incorrect")

func config_level():
	var level = Globals.levels[Globals.user_data.level]
	Level.text = str(Globals.user_data.level+1)
	level = level.split(" ", false)
	solution = level[1]
	for index in level[0].length():
		Cells[index].set_color(level[0][index])
	for index in level[2].length():
		if level[2][index] != "-":
			Cells[index].lock()
			Cells[index].set_number(level[2][index])
	if Globals.user_data.game != "":
		for i in Globals.user_data.game.length():
			var num = Globals.user_data.game[i]
			if num == "-":
				num = ""
			if Cells[i].state == "editable":
				Cells[i].set_number(num)
			if Globals.user_data.showed_cells.has(i):
				Cells[i].solved(num)
	update_clues()

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
	Globals.user_data.game = actual_conf
	Globals.user_data.showed_cells = showed_cells
	Globals.save_game()
