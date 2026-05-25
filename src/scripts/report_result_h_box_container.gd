class_name ReportResultHBoxContainer extends HBoxContainer


@onready var player_name_label : Label = $PlayerNameLabel
@onready var result_colorrect : ColorRect = $MarginContainer/ResultColorRect
@onready var result_label : Label = $MarginContainer/ResultLabel


func _ready() -> void:
	pass # Replace with function body.

func set_all(_name : String, _result_color : Color, _result_text : String) -> void:
	player_name_label.text = _name
	result_colorrect.color = _result_color
	result_label.text = _result_text
