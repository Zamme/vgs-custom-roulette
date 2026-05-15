class_name SaveLoadManager extends Node

func _ready() -> void:
	Globals.save_load_manager = self

func load_roulette(_roulette_name : String):
	var _roulette_file : ConfigFile = ConfigFile.new()
	var _roulette_filepath : String = "user://" + _roulette_name + ".rul"
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
	
	var _filename : String = "user://" + _roulette_info.r_name + ".rul"
	var _error : Error = _roulete_file.save(_filename)
	_saved = _error == OK
	return _saved
