extends Node
class_name SegmentInfo

var s_name: String = ""
var s_color: Color = Color.WHITE

func _init(name: String, color: Color) -> void:
	self.s_name = name
	self.s_color = color
