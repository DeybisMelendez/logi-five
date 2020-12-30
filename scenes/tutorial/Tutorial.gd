extends Control

onready var Home = $VBoxContainer/HBoxContainer/Home
const MAIN_PATH = "res://scenes/main/Main.tscn"
func _ready():
	Home.connect("button_up", self, "home")

func home():
	Background.change_scene(MAIN_PATH)
