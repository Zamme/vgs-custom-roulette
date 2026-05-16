class_name SaveLoadManager extends Node

const ROULETTES_DIRNAME = "roulettes"
const USER_PREFIX = "user://"
const ROULETTES_FILES_EXT = ".rul"

func _ready() -> void:
	Globals.save_load_manager = self

func check_roulettes_dir():
	var dir_path : String = USER_PREFIX + ROULETTES_DIRNAME
	print(dir_path)
	if not DirAccess.dir_exists_absolute(dir_path):
		print("Rouletes dir not found. Creating...")
		var _error : Error = DirAccess.make_dir_absolute(dir_path)
		if _error:
			print("Error: ", _error)
		else:
			print("Rouletes dir created succesfully.")

func exists_roulette_file(_roulette_name : String) -> bool:
	var _roulette_filepath : String = USER_PREFIX + ROULETTES_DIRNAME.path_join(_roulette_name) + ROULETTES_FILES_EXT
	return FileAccess.file_exists(_roulette_filepath)

func load_roulette(_roulette_name : String):
	var _roulette_file : ConfigFile = ConfigFile.new()
	var _roulette_filepath : String = USER_PREFIX + ROULETTES_DIRNAME.path_join(_roulette_name) + ROULETTES_FILES_EXT
	check_roulettes_dir()
	_roulette_file.load(_roulette_filepath)
	
	var _segments : Array = Array()
	var _sections_strings : Array = _roulette_file.get_sections()
	_sections_strings.pop_front()
	for _section_string in _sections_strings:
		_segments.append(SegmentInfo.new(_section_string, _roulette_file.get_value(_section_string, "Color")))
	var _roulette_info : RouletteInfo = RouletteInfo.new(_roulette_file.get_value("General", "Name", "Ruleta"),
														_roulette_file.get_value("General", "Description", "Una Ruleta"),
														_segments,
														_roulette_file.get_value("General", "RadioDev", 0.5),
														_roulette_file.get_value("General", "FontSize", 20))
	return _roulette_info

func save_roulette(_roulette_info : RouletteInfo) -> bool:
	var _saved : bool
	var _roulete_file : ConfigFile = ConfigFile.new()
	
	_roulete_file.set_value("General", "Name", _roulette_info.r_name)
	_roulete_file.set_value("General", "Description", _roulette_info.r_description)
	_roulete_file.set_value("General", "RadioDev", _roulette_info.r_radio_dev)
	_roulete_file.set_value("General", "FontSize", _roulette_info.r_mida_font)
	for _segment in _roulette_info.r_segments:
		_roulete_file.set_value(_segment.s_name, "Name", _segment.s_name)
		_roulete_file.set_value(_segment.s_name, "Color", _segment.s_color)
	
	var _roulette_filepath : String = USER_PREFIX + ROULETTES_DIRNAME.path_join(_roulette_info.r_name) + ROULETTES_FILES_EXT
	check_roulettes_dir()
	var _error : Error = _roulete_file.save(_roulette_filepath)
	_saved = _error == OK
	return _saved
