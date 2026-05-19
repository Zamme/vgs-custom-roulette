extends VBoxContainer


var segment_n : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_segment_color_picker_button_color_changed(color: Color) -> void:
	Globals.roulete_editor_scene.roulette_info.r_segments[segment_n].s_color = color
	Globals.roulete_editor_scene.update_roulette_segments(Globals.roulete_editor_scene.roulette_info.r_segments)
	pass # Replace with function body.


func _on_segment_name_line_edit_text_submitted(new_text: String) -> void:
	Globals.roulete_editor_scene.roulette_info.r_segments[segment_n].s_name = new_text
	Globals.roulete_editor_scene.update_roulette_segments(Globals.roulete_editor_scene.roulette_info.r_segments)
	pass # Replace with function body.
