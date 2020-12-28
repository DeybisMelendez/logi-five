extends TextureButton

var level = 1
var state = "locked"
const SEED = "DeybisMelendez"

func _ready():
	connect("button_up", self, "pressed")
	if state == "locked":
		disabled = true
	else:
		$Label.text = str(level)

func pressed():
	Globals.actual_level = level
