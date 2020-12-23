extends Node

var can_play = Globals.user_data.can_play_sound

func play(sound):
	if can_play:
		get_node(sound).play()

func _ready():
	$HBoxContainer/Sound.connect("toggled", self, "sound_on_off")

func sound_on_off(b):
	can_play = b
	Globals.save_game()
