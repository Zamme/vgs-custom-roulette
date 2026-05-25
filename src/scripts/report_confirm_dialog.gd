class_name ReportConfirmDialog extends ConfirmationDialog


@onready var reports_result_vbox : VBoxContainer = $ScrollContainer/ReportsResultsVBoxContainer

var report_result_hbox_container_prefab : PackedScene = preload("res://src/ui/report_result_h_box_container.tscn")


func _ready() -> void:
	Globals.report_dialog = self

func clear_results_container() -> void:
	for _child in reports_result_vbox.get_children():
		_child.queue_free()

func update_results_container(_match_info : MatchInfo) -> void:
	clear_results_container()
	var current_match_info : MatchInfo = _match_info
	var results : Dictionary = current_match_info.match_results
	var roulette_info : RouletteInfo = current_match_info.roulette_info
	var results_keys : Array = results.keys()
	for result_key in results_keys:
		var _new_report_result : ReportResultHBoxContainer = report_result_hbox_container_prefab.instantiate()
		reports_result_vbox.add_child(_new_report_result)
		var _player_name : String = result_key
		var _segment_info : SegmentInfo = roulette_info.r_segments[results[result_key]]
		var _result_text : String = _segment_info.s_name
		var _result_color : Color = _segment_info.s_color
		_new_report_result.set_all(_player_name, _result_color, _result_text)
