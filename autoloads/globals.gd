extends Node

var levels = []
var user_data = {
	level = 78,
	clues = 5,
	game = "",
	showed_cells = []
}

var colors = {
	F=Color("ffff96"),
	I=Color("9696ff"),
	L=Color("ff9696"),
	N=Color("0000c8"),
	P=Color("96ff96"),
	T=Color("96ffff"),
	U=Color("ff96ff"),
	V=Color("00c8c8"),
	W=Color("00c800"),
	X=Color("c80000"),
	Y=Color("c800c8"),
	Z=Color("c8c800"),
}

func _ready():
	load_levels()
	load_game()

func load_levels():
	var f = File.new()
	f.open("levels.txt",File.READ)
	levels = f.get_as_text().split("\n", false)
	f.close()

func save_game():
	var f = File.new()
	f.open("user://user.dat", File.WRITE)
	f.store_var(user_data)
	f.close()

func load_game():
	var f = File.new()
	if !f.file_exists("user://user.dat"):
		return
	f.open("user://user.dat", File.READ)
	user_data = f.get_var()
	f.close()


