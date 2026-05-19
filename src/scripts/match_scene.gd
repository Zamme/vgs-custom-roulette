class_name MatchScene extends Node3D


const default_rotation_velocity : Vector3 = Vector3(0, -10.0, 0.0) 
const default_damp : float = 0.5

@onready var roulette_rb : MatchRoulette = $MatchRoulette
@onready var load_roulette_popup : FileDialog = $MatchControl/LoadRouletteFileDialog
@onready var load_game_popup : FileDialog = $MatchControl/LoadGameFileDialog
@onready var load_match_popup : FileDialog = $MatchControl/LoadMatchFileDialog
@onready var ambient_audio : AudioStreamPlayer = $AmbientAudio
@onready var rolling_audio : AudioStreamPlayer = $RollingAudio
@onready var hey_audio : AudioStreamPlayer = $HeyAudio
@onready var music_audio : AudioStreamPlayer = $MusicAudio

@onready var rot_spinbox: SpinBox = $MatchControl/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/RotationSpinBox


# Ajuste fino si tu flecha no empieza en el "Grado 0" del shader
# Si la flecha está arriba, abajo o a un lado, ajustamos este offset.
@export_range(0, 360) var arrow_offset: float = 72.0


var match_info : MatchInfo = MatchInfo.new()

var labels_container_packedscene : PackedScene = preload("res://src/editor/labels_container.tscn")
var labels_container_instance : LabelsContainer = null
var is_roulette_rolling : bool


func _ready() -> void:
	Globals.match_scene = self
	new_match()
	#play_music_audio(true)
	#play_ambient_audio(true)
	#check_roulette_result()
	#rot_spinbox.value = -107

func check_roulette_result() -> void:
	print("Roulette Rotation: ", rad_to_deg(roulette_rb.global_rotation.y))
	print("Segment: ", get_segment_result())

func get_segment_result() -> int:
	var n_segments : int = match_info.roulette_info.r_segments.size()
	var rot_and_deg = fposmod(rad_to_deg(roulette_rb.global_rotation.y), 360.0)
	
	var fixed_degrees = rot_and_deg - 180.0
	fixed_degrees -= arrow_offset
	fixed_degrees = fposmod(fixed_degrees, 360.0)
	var degrees_per_segment = 360.0 / n_segments
	var segment_id = floor(fixed_degrees / degrees_per_segment)
	
	#segment_id = (n_segments - 1) - segment_id
	segment_id = int(fposmod(segment_id, n_segments))
	
	return segment_id

func go_roulette() -> void:
	check_roulette_result()
	is_roulette_rolling = true
	play_ambient_audio(false)
	play_music_audio(false)
	play_rolling_audio(true)
	roulette_rb.angular_velocity = default_rotation_velocity

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

func play_ambient_audio(_play : bool) -> void:
	ambient_audio.playing = _play

func play_music_audio(_play : bool) -> void:
	music_audio.playing = _play

func play_rolling_audio(_play : bool) -> void:
	rolling_audio.playing = _play

func roulette_stopped():
	is_roulette_rolling = false
	play_rolling_audio(false)
	hey_audio.play()
	check_roulette_result()

func save_match():
	var _saved : bool = Globals.save_load_manager.save_match(match_info)
	print("Saved: " + str(_saved))

func start_match() -> void:
	pass

func stop_roulette() -> void:
	roulette_rb.angular_damp = default_damp

func update_labels_container() -> void:
	var roulette_info : RouletteInfo = match_info.roulette_info
	if labels_container_instance:
		labels_container_instance.queue_free()
	labels_container_instance = labels_container_packedscene.instantiate()
	roulette_rb.add_child(labels_container_instance)
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
			Globals.game_manager.load_main_menu()

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

func _on_save_match_file_dialog_file_selected(_path: String) -> void:
	pass # Replace with function body.

func _on_go_button_button_down() -> void:
	if match_info.match_state == 2:
		go_roulette()

func _on_go_button_button_up() -> void:
	if match_info.match_state == 2:
		stop_roulette()

func _on_rotation_spin_box_value_changed(value: float) -> void:
	roulette_rb.global_rotation.y = deg_to_rad(round(value))
	check_roulette_result()

func _on_state_popup_menu_index_pressed(index: int) -> void:
	match index:
		0:
			pass
		1:
			start_match()
