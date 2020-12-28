extends ColorRect

onready var Number = $Number
onready var Btn = $Btn

var state = "editable"

func set_color(c, group):
	color = c
	add_to_group(group)

func set_number(number):
	Number.text = number

func get_number():
	return Number.text

func solved(solution):
	set_number(solution)
	var font = load("res://assets/fonts/Roboto/CellBold.tres")
	Number.add_font_override("font", font)
	Btn.disabled = true
	state = "solved"

func _ready():
	Btn.connect("button_up", self, "pressed")

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
		Audio.play("Touch")
