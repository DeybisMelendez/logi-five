extends Control

onready var Back = $VBoxContainer/Back
onready var Hard = $VBoxContainer/Hard
onready var Medium = $VBoxContainer/Medium
onready var Easy = $VBoxContainer/Easy
const MAIN_PATH = "res://scenes/main/Main.tscn"
const LEVEL_PATH = "res://scenes/level/Level.tscn"

func _ready():
	Back.connect("button_up", self, "back")
	Hard.connect("button_up", self, "hard")
	Medium.connect("button_up", self, "medium")
	Easy.connect("button_up", self, "easy")

func back():
	get_tree().change_scene(MAIN_PATH)

func level():
	get_tree().change_scene(LEVEL_PATH)

func hard():
	Globals.actual_difficulty = "Hard"
	level()

func medium():
	Globals.actual_difficulty = "Medium"
	level()

func easy():
	Globals.actual_difficulty = "Easy"
	level()
