extends Control


onready var Play = $VBoxContainer/Play
onready var Statistics = $VBoxContainer/Statistics
onready var levels = $VBoxContainer/Levels
onready var Tutorial = $VBoxContainer/Tutorial
const DIFF_PATH = "res://scenes/diff/Diff.tscn"
const STATS_PATH = "res://scenes/stats/Stats.tscn"
const LEVEL_PATH = "res://scenes/level_select/LevelSelect.tscn"
const TUTORIAL_PATH = "res://scenes/tutorial/Tutorial.tscn"

func _ready():
	Play.connect("button_up", self, "play")
	Statistics.connect("button_up", self, "stats")
	levels.connect("button_up", self, "levels")
	Tutorial.connect("button_up", self, "tutorial")

func play():
	Background.change_scene(DIFF_PATH)

func levels():
	Background.change_scene(LEVEL_PATH)

func stats():
	Background.change_scene(STATS_PATH)

func tutorial():
	Background.change_scene(TUTORIAL_PATH)
