extends Control


onready var Play = $VBoxContainer/Play
onready var Statistics = $VBoxContainer/Statistics
const DIFF_PATH = "res://scenes/diff/Diff.tscn"
const STATS_PATH = "res://scenes/stats/Stats.tscn"
func _ready():
	Play.connect("button_up", self, "play")
	Statistics.connect("button_up", self, "stats")

func play():
	Background.change_scene(DIFF_PATH)

func stats():
	Background.change_scene(STATS_PATH)
