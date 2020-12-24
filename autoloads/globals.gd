extends Node
var actual_difficulty = "Hard"
var levels = []
var conf = {
	can_play_sound = true,
}
var user_data = {
	diff = {
		Easy = {
			game = "",
			solved_cells = [],
			conf = "",
			solution = "",
			time = 0,
			level = -1,
			clues = 5
		},
		Medium = {
			game = "",
			solved_cells = [],
			conf = "",
			solution = "",
			time = 0,
			level = -1,
			clues = 5
		},
		Hard = {
			game = "",
			solved_cells = [],
			conf = "",
			solution = "",
			time = 0,
			level = -1,
			clues = 5
		}
	}
}

var stats = {
	diff = {
		Hard = {
			trophies = 0,
			best = 0,
			history = []
		},
		Medium = {
			trophies = 0,
			best = 0,
			history = []
		},
		Easy = {
			trophies = 0,
			best = 0,
			history = []
		}
	}
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
	user_data = load_file("user://user.dat", user_data)
	stats = load_file("user://stats.dat", stats)
	conf = load_file("user://config.dat", conf)

func load_levels():
	var f = File.new()
	f.open("levels.txt",File.READ)
	levels = f.get_as_text().split("\n", false)
	f.close()

func save_game():
	save_file("user://user.dat", user_data)

func save_stats():
	save_file("user://stats.dat", stats)

func save_conf():
	save_file("user://config.dat", conf)

func save_file(file_path, data):
	var f = File.new()
	f.open(file_path, File.WRITE)
	f.store_var(data)
	f.close()

func load_file(file_path, none):
	var f = File.new()
	if !f.file_exists(file_path):
		return none
	f.open(file_path, File.READ)
	var data = f.get_var()
	f.close()
	return data
