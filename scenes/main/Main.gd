extends Control


onready var Play = $VBoxContainer/Play
onready var Continue = $VBoxContainer/Continue
onready var Level = $HBoxContainer/Level
var level_path = "res://scenes/level/Level.tscn"

func _ready():
	Play.connect("button_up", self, "play")
	Level.text = str(Globals.user_data.level)

func play():
	get_tree().change_scene(level_path)
