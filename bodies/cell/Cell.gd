extends ColorRect

onready var Number = $Number
onready var Btn = $Btn

var state = "editable"

func set_color(code):
	color = Globals.colors[code]

func set_number(number):
	Number.text = number

func get_number():
	return Number.text

func lock():
	state = "locked"
	var font = load("res://assets/fonts/Roboto/CellBold.tres")
	Number.add_font_override("font", font)
	#Number.add_color_override("font_color", Color)
	Btn.disabled = true

func solved(solution):
	state = "solved"
	var font = load("res://assets/fonts/Roboto/CellBold.tres")
	Number.add_font_override("font", font)
	Number.add_color_override("font_color", Color.brown)
	set_number(solution)
	Btn.disabled = true

func _ready():
	Btn.connect("button_up", self, "pressed")
	match state:
		"locked":
			pass
		"solved":
			pass

func pressed():
	if state == "editable":
		if Number.text == "":
			Number.text = "1"
		elif Number.text == "5":
			Number.text = ""
		else:
			var n = int(Number.text) + 1
			Number.text = str(n)
	get_tree().current_scene.save_actual_game()
