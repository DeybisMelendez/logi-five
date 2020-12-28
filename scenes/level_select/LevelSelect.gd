extends Control

var button = preload("res://bodies/level_button/LevelButton.tscn")
onready var grid = $VBoxContainer/ScrollContainer/CenterContainer/GridContainer

func _ready():
	for i in 100:
		var n = button.instance()
		n.level = i+1
		grid.add_child(n)
