extends Node
class_name RouletteInfo

var r_name: String
var r_description: String
var r_segments: Array
var r_radio_dev: float = 0.5
var r_mida_font: float = 22.0

func _init(name: String, description: String, segments: Array, radio_dev: float = 0.5, mida_font: float = 22.0) -> void:
	self.r_name = name
	self.r_description = description
	self.r_segments = segments
	self.r_radio_dev = radio_dev
	self.r_mida_font = mida_font

func print_info() -> void:
	print("Name: ", r_name)
	print("Description: ", r_description)
	for _segment in r_segments:
		print("Segment: ", _segment.s_name)
		print("Color: ", _segment.s_color)
