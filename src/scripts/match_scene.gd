class_name MatchScene extends Node3D


@onready var roulette_rb : MatchRoulette = $MatchRoulette
@onready var load_roulette_popup : FileDialog = $MatchControl/LoadRouletteFileDialog
@onready var load_game_popup : FileDialog = $MatchControl/LoadGameFileDialog
@onready var load_match_popup : FileDialog = $MatchControl/LoadMatchFileDialog

var match_info : MatchInfo = MatchInfo.new()

var labels_container_packedscene : PackedScene = preload("res://src/editor/labels_container.tscn")
var labels_container_instance : LabelsContainer = null


func _ready() -> void:
	Globals.match_scene = self
	new_match()

func load_game(_game_name : String) -> void:
	match_info.game_info = Globals.save_load_manager.load_game(_game_name)
	update_match_scene()

func load_match(_match_name : String) -> void:
	match_info = Globals.save_load_manager.load_match(_match_name)
	update_match_scene()

func load_roulette(_roulette_name : String) -> void:
	match_info.roulette_info = Globals.save_load_manager.load_roulette(_roulette_name)
	update_match_scene()

func new_match() -> void:
	match_info = MatchInfo.new()
	match_info.create_default_match()
	update_match_scene()

func save_match():
	var _saved : bool = Globals.save_load_manager.save_match(match_info)
	print("Saved: " + str(_saved))

func update_labels_container() -> void:
	var roulette_info : RouletteInfo = match_info.roulette_info
	if labels_container_instance:
		labels_container_instance.queue_free()
	labels_container_instance = labels_container_packedscene.instantiate()
	add_child(labels_container_instance)
	labels_container_instance.generar_textos_radiales(roulette_info.r_segments, roulette_info.r_radio_dev, roulette_info.r_mida_font)
	labels_container_instance.global_position.y = 0.2

func update_match_control() -> void:
	Globals.match_control.update_all()

func update_match_scene() -> void:
	update_roulette()
	update_match_control()

func update_roulette() -> void:
	roulette_rb.update_roulette_object(match_info.roulette_info)
	update_labels_container()

func _on_match_menu_index_pressed(index: int) -> void:
	match index:
		0:
			new_match()
		1:
			Globals.save_load_manager.check_matches_dir()
			if load_match_popup.root_subfolder == "":
				load_match_popup.root_subfolder = Globals.save_load_manager.MATCHES_DIRNAME
			load_match_popup.popup_centered()
		2:
			save_match()
		3:
			pass
		4:
			pass

func _on_match_properties_popup_menu_index_pressed(index: int) -> void:
	match index:
		0:
			Globals.save_load_manager.check_roulettes_dir()
			if load_roulette_popup.root_subfolder == "":
				load_roulette_popup.root_subfolder = Globals.save_load_manager.ROULETTES_DIRNAME
			load_roulette_popup.popup_centered()
		1:
			Globals.save_load_manager.check_games_dir()
			if load_game_popup.root_subfolder == "":
				load_game_popup.root_subfolder = Globals.save_load_manager.GAMES_DIRNAME
			load_game_popup.popup_centered()

func _on_load_roulette_file_dialog_file_selected(path: String) -> void:
	var _roulette_name : String = path.get_basename().get_file()
	load_roulette(_roulette_name)

func _on_load_game_file_dialog_file_selected(path: String) -> void:
	var _game_name : String = path.get_basename().get_file()
	load_game(_game_name)

func _on_load_match_file_dialog_file_selected(path: String) -> void:
	var _match_name : String = path.get_basename().get_file()
	load_match(_match_name)

func _on_save_match_file_dialog_file_selected(path: String) -> void:
	pass # Replace with function body.
