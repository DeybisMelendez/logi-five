extends Node
var actual_difficulty = "Hard"
var actual_level = 1
var levels = []
var conf = {
	can_play_sound = true,
}
var user_data = {
	diff = {
		Easy = {
			user_solution = "",
			time = 0,
			level_seed = -1,
		},
		Medium = {
			user_solution = "",
			time = 0,
			level_seed = -1,
		},
		Hard = {
			user_solution = "",
			time = 0,
			level_seed = -1,
		}
	},
	levels = [],
	max_level = 1
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

func _ready():
	load_levels()
	user_data = load_file("user://user.dat", user_data)
	stats = load_file("user://stats.dat", stats)
	conf = load_file("user://config.dat", conf)

func load_levels():
	var f = File.new()
	f.open("res://levels.txt",File.READ)
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
