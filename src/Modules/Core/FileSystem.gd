extends Node

const CONFIG_FILE_PATH = "user://settings.cfg"

func concat_path(paths: Array) -> String:
	var out := ""
	for i in range(len(paths)):
		out = out.plus_file(paths[i])
	return out

func get_contents(path) -> Dictionary:
	var files = []
	var directories = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var name = dir.get_next()
		while name != "":
			if dir.current_is_dir():
				directories.append(name)
			else:
				if name.ends_with(".import"):
					files.append(name.rstrip(".import"))
			name = dir.get_next()
	else:
		push_error("HEY! An error occurred when trying to access the path: %s" % path)
	directories.erase(".")
	directories.erase("..")
	return {
		"files": files,
		"directories": directories,
	}

func get_files(path) -> Array:
	return get_contents(path)["files"]
	
func get_directories(path):
	return get_contents(path)["directories"]

func get_config_file() -> ConfigFile:
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err != OK:
		# Create new config file if doesn't exist
		config.save(CONFIG_FILE_PATH)
	return config

func set_config_file(config: ConfigFile) -> void:
	config.save(CONFIG_FILE_PATH)
