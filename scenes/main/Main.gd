extends Control


onready var Play = $VBoxContainer/Play
onready var Continue = $VBoxContainer/Continue
onready var Trophies = $HBoxContainer/Trophies
const DIFF_PATH = "res://scenes/diff/Diff.tscn"

func _ready():
	Play.connect("button_up", self, "play")
	Trophies.text = str(Globals.user_data.trophies)

func play():
	get_tree().change_scene(DIFF_PATH)
