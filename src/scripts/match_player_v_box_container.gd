class_name MatchPlayerVBox extends VBoxContainer


@onready var player_name_label : Label = $PlayerNameLabel
@onready var result_color_rect : ColorRect = $MarginContainer/ResultColorRect
@onready var result_label : Label = $MarginContainer/ResultLabel


func _ready() -> void:
	pass # Replace with function body.

func set_player_name_label(_text : String) -> void:
	player_name_label.text = _text

func set_result_color_rect(_color : Color) -> void:
	result_color_rect.color = _color

func set_result_label(_text : String) -> void:
	result_label.text = _text
