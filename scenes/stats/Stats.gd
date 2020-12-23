extends Control

onready var Back = $VBoxContainer/Back
onready var BestHard = $VBoxContainer/BestHard/Data
onready var WinsHard = $VBoxContainer/WinsHard/Data
onready var AverageHard = $VBoxContainer/AverageHard/Data
onready var BestMedium = $VBoxContainer/BestMedium/Data
onready var WinsMedium = $VBoxContainer/WinsMedium/Data
onready var AverageMedium = $VBoxContainer/AverageMedium/Data
onready var BestEasy = $VBoxContainer/BestEasy/Data
onready var WinsEasy = $VBoxContainer/WinsEasy/Data
onready var AverageEasy = $VBoxContainer/AverageEasy/Data
const MAIN_PATH = "res://scenes/main/Main.tscn"
func _ready():
	Back.connect("button_up", self, "back")
	var hard = Globals.stats.diff.Hard
	var medium = Globals.stats.diff.Medium
	var easy = Globals.stats.diff.Easy
	BestHard.text = str(hard.best)
	WinsHard.text = str(hard.history.size())
	AverageHard.text = str(average(hard.history))
	BestMedium.text = str(medium.best)
	WinsMedium.text = str(medium.history.size())
	AverageMedium.text = str(average(medium.history))
	BestEasy.text = str(easy.best)
	WinsEasy.text = str(easy.history.size())
	AverageEasy.text = str(average(easy.history))

func average(arr):
	if arr.size() > 0:
		var total = 0
		for i in arr:
			total += i
		return total/arr.size()
	return 0

func back():
	Background.change_scene(MAIN_PATH)
