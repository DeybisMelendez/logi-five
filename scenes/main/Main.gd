extends Control


onready var Play = $VBoxContainer/Play
const DIFF_PATH = "res://scenes/diff/Diff.tscn"

func _ready():
	Play.connect("button_up", self, "play")

func play():
	Background.change_scene(DIFF_PATH)
