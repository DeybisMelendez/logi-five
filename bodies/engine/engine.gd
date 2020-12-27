extends GridContainer

onready var Cells = get_children()
var levels = Globals.levels
var diff = Globals.actual_difficulty
var data = Globals.user_data.diff[diff]

func check_solution():
	var user_solution = ""
	for cell in Cells:
		user_solution += cell.get_number()
	return data.solution == user_solution

func set_colors(conf):
	for index in conf.length():
		Cells[index].set_color(conf[index])

func set_solved_cells(solution):
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
	for i in solved_cells:
		Cells[i].solved(solution[i])

func set_user_solution(user_solution):
	if user_solution != "":
		for i in Cells.size():
			var cell = Cells[i]
			if cell.state == "editable":
				var num = user_solution[i]
				if num == "-":
					num = ""
				cell.set_number(num)

func get_user_solution():
	var user_solution = ""
	for cell in Cells:
		if cell.get_number() == "":
			user_solution += "-"
		else:
			user_solution += cell.get_number()
	return user_solution

func generate_level(user_solution):
	var level = levels[randi()%levels.size()].split(" ", false)
	var rots = randi()%5
	var conf = rot(level[0], rots)
	var solution = rot(level[1], rots)
	set_colors(conf)
	set_solved_cells(solution)
	set_user_solution(user_solution)

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

func erase():
	for cell in Cells:
		if cell.state == "editable":
			cell.set_number("")
