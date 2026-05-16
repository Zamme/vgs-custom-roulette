class_name RouletteInfo

var r_name: String
var r_description: String
var r_segments: Array
var r_radio_dev: float = 0.5
var r_mida_font: float = 22.0

func _init(name: String = "", description: String = "", segments: Array = [], radio_dev: float = 0.5, mida_font: float = 22.0) -> void:
	self.r_name = name
	self.r_description = description
	self.r_segments = segments
	self.r_radio_dev = radio_dev
	self.r_mida_font = mida_font

func clone() -> RouletteInfo:
	var _clone : RouletteInfo = RouletteInfo.new()
	_clone.r_name = r_name
	_clone.r_description = r_description
	_clone.r_radio_dev = r_radio_dev
	_clone.r_mida_font = r_mida_font
	_clone.r_segments = r_segments.duplicate()
	return _clone

func print_info() -> void:
	print("Name: ", r_name)
	print("Description: ", r_description)
	for _segment in r_segments:
		print("Segment: ", _segment.s_name)
		print("Color: ", _segment.s_color)
