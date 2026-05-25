class_name GameEditorControl extends Control


@onready var nom_joc_lineedit : LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/NomJocLineEdit
@onready var descripcio_joc_lineedit : LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/DescripcioJocLineEdit
@onready var player_vbox : VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/vBoxContainer3/PanelContainer/VBoxContainer/ScrollContainer/PlayersVBox
@onready var new_confirmation_dialog : ConfirmationDialog = $NewConfirmationDialog
@onready var save_confirmation_dialog : ConfirmationDialog = $SaveConfirmationDialog
@onready var load_file_dialog : FileDialog = $LoadFileDialog

var player_hbox_prefab : PackedScene = preload("res://src/ui/player_editing_h_box.tscn")

var game_info_default : GameInfo = GameInfo.new("Joc Nou", "Descripcio de joc nou", [PlayerInfo.new("Nom Jugador")])
var game_info : GameInfo


func _ready() -> void:
	Globals.game_editor_scene = self
	new_game()

func add_player() -> void:
	var _player_name_default = "Nom Jugador"
	var _player_name : String = _player_name_default
	var _player_index : int = 0
	while check_player_exists(_player_name):
		_player_index += 1
		_player_name = _player_name_default + " " + str(_player_index)
	var new_player : PlayerInfo = PlayerInfo.new(_player_name)
	game_info.g_players.append(new_player)
	update_editor()

func check_player_exists(_player_name : String) -> bool:
	var _exists : bool = false
	for _player in game_info.g_players:
		if _player.p_name == _player_name:
			_exists = true
	return _exists

func clear_players_vbox() -> void:
	for _child in player_vbox.get_children():
		_child.queue_free()

func delete_player(_index : int) -> void:
	game_info.g_players.remove_at(_index)
	update_editor()

func fill_players_vbox() -> void:
	clear_players_vbox()
	for i_player in game_info.g_players.size():
		var new_player : PlayerEditingHBox = player_hbox_prefab.instantiate()
		player_vbox.add_child(new_player)
		if i_player == 0:
			new_player.up_button.disabled = true
			if game_info.g_players.size() == 1:
				new_player.delete_button.disabled = true
		if i_player == game_info.g_players.size()-1:
			new_player.down_button.disabled = true
		new_player.create_player(i_player, game_info.g_players[i_player])

func load_game(_game_name : String) -> void:
	game_info = Globals.save_load_manager.load_game(_game_name)
	update_editor()

func modify_player_name(_player_index : int, _name : String) -> void:
	game_info.g_players[_player_index].p_name = _name
	update_editor()

func move_player_down(_index : int):
	var temp_player = game_info.g_players[_index+1]
	game_info.g_players[_index+1] = game_info.g_players[_index]
	game_info.g_players[_index] = temp_player
	update_editor()

func move_player_up(_index : int):
	var temp_player = game_info.g_players[_index-1]
	game_info.g_players[_index-1] = game_info.g_players[_index]
	game_info.g_players[_index] = temp_player
	update_editor()

func new_game() -> void:
	game_info = game_info_default.clone()
	update_editor()

func save_game():
	var _saved : bool = Globals.save_load_manager.save_game(game_info)
	print("Saved: " + str(_saved))

func update_editor() -> void:
	nom_joc_lineedit.text = game_info.g_name
	descripcio_joc_lineedit.text = game_info.g_description
	fill_players_vbox()

func _on_add_player_button_button_up() -> void:
	add_player()

func _on_options_menu_index_pressed(index: int) -> void:
	match index:
		0:
			new_confirmation_dialog.popup_centered()
		1:
			Globals.save_load_manager.check_games_dir()
			if load_file_dialog.root_subfolder == "":
				load_file_dialog.root_subfolder = Globals.save_load_manager.GAMES_DIRNAME
			load_file_dialog.popup_centered()
			#load_roulette()
		2:
			if Globals.save_load_manager.exists_game_file(game_info.g_name):
				save_confirmation_dialog.popup_centered()
			else:
				save_game()
		3:
			Globals.game_manager.load_main_menu()

func _on_load_file_dialog_file_selected(path: String) -> void:
	var _game_name : String = path.get_basename().get_file()
	load_game(_game_name)

func _on_new_confirmation_dialog_confirmed() -> void:
	new_game()

func _on_save_confirmation_dialog_confirmed() -> void:
	save_game()

func _on_nom_joc_line_edit_editing_toggled(toggled_on: bool) -> void:
	game_info.g_name = nom_joc_lineedit.text

func _on_descripcio_joc_line_edit_editing_toggled(toggled_on: bool) -> void:
	game_info.g_description = descripcio_joc_lineedit.text
