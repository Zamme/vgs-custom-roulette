class_name MatchControl extends Control


@onready var players_vbox_container = $PanelContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/PlayersMainVBoxContainer/MarginContainer/PanelContainer/VBoxContainer/ScrollContainer/PlayersVBoxContainer
@onready var match_name_lineedit : LineEdit = $PanelContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/MatchNameLineEdit

var match_player_vbox_prefab : PackedScene = preload("res://src/ui/match_player_v_box_container.tscn")


func _ready() -> void:
	Globals.match_control = self

func clear_players_list() -> void:
	for _child in players_vbox_container.get_children():
		_child.queue_free()

func update_all() -> void:
	update_match_lineedit()
	update_players_list()

func update_match_lineedit():
	match_name_lineedit.text = Globals.match_scene.match_info.match_name

func update_players_list() -> void:
	clear_players_list()
	var _current_match_info : MatchInfo = Globals.match_scene.match_info
	var _players : Array = Globals.match_scene.match_info.game_info.g_players
	for i_player in _players.size():
		var _new_sep : HSeparator = HSeparator.new()
		players_vbox_container.add_child(_new_sep)
		var _new_mpvbox : MatchPlayerVBox = match_player_vbox_prefab.instantiate()
		players_vbox_container.add_child(_new_mpvbox)
		_new_mpvbox.set_player_name_label(_players[i_player].p_name)
		var _nom_jugador : String = _players[i_player].p_name
		var i_player_segment_result : int = -1
		if _current_match_info.match_results.has(_nom_jugador):
			i_player_segment_result = _current_match_info.match_results[_nom_jugador]
		if i_player_segment_result > -1:
			var _player_segment : SegmentInfo = _current_match_info.roulette_info.r_segments[i_player_segment_result]
			var _player_result_text : String = _player_segment.s_name
			var _player_result_color : Color = _player_segment.s_color
			_new_mpvbox.set_result_label(_player_result_text)
			#var _color : Color = 
			_new_mpvbox.set_result_color_rect(_player_result_color)
			pass
		else:
			_new_mpvbox.set_result_color_rect(Color.GRAY)
	var _new_sep2 : HSeparator = HSeparator.new()
	players_vbox_container.add_child(_new_sep2)

func _on_match_name_line_edit_editing_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		Globals.match_scene.match_info.match_name = match_name_lineedit.text
