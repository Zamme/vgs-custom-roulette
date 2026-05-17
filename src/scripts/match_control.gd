class_name MatchControl extends Control


@onready var players_vbox_container = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/PlayersMainVBoxContainer
@onready var match_name_lineedit : LineEdit = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/VBoxContainer/MatchNameLineEdit

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
	var _players : Array = Globals.match_scene.match_info.game_info.g_players
	for _player in _players:
		var _new_mpvbox : MatchPlayerVBox = match_player_vbox_prefab.instantiate()
		players_vbox_container.add_child(_new_mpvbox)
		_new_mpvbox.set_player_name_label(_player.p_name)

func _on_match_name_line_edit_editing_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		Globals.match_scene.match_info.match_name = match_name_lineedit.text
