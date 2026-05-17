class_name MatchControl extends Control


@onready var players_vbox_container = $MatchControl/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/PlayersMainVBoxContainer/MarginContainer/PanelContainer/VBoxContainer/PlayersVBoxContainer

var match_player_vbox_prefab : PackedScene = preload("res://src/ui/match_player_v_box_container.tscn")


func _ready() -> void:
	Globals.match_control = self
	update_players_list()

func update_all() -> void:
	update_players_list()

func update_players_list() -> void:
	var _players : Array = Globals.match_scene.match_info.game_info.g_players
	for _player in _players:
		var _new_mpvbox : MatchPlayerVBox = match_player_vbox_prefab.instantiate()
		players_vbox_container.add_child(_new_mpvbox)
		#_new_mpvbox.set_player_name_label(_player.p_name)
