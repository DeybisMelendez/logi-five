extends Node

onready var can_play = Globals.conf.can_play_sound

func play(sound):
	if can_play:
		get_node(sound).play()

func _ready():
	$HBoxContainer/Sound.connect("toggled", self, "sound_on_off")
	$HBoxContainer/Sound.pressed = can_play

func sound_on_off(b):
	can_play = b
	Globals.conf.can_play_sound = b
	Globals.save_conf()
