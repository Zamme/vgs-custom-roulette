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


# Ajuste fino si tu flecha no empieza en el "Grado 0" del shader
# Si la flecha está arriba, abajo o a un lado, ajustamos este offset.
@export_range(0, 360) var offset_flecha_grados: float = 270.0


var match_info : MatchInfo = MatchInfo.new()

var labels_container_packedscene : PackedScene = preload("res://src/editor/labels_container.tscn")
var labels_container_instance : LabelsContainer = null
var is_roulette_rolling : bool


func _ready() -> void:
	Globals.match_scene = self
	new_match()
	play_music_audio(true)
	play_ambient_audio(true)
	check_roulette_result()

func check_roulette_result() -> void:
	print("Roulette Rotation: ", rad_to_deg(roulette_rb.global_rotation.y))
	print("Segment: ", obtener_segmento_apuntado() +1)

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

func _on_go_button_button_down() -> void:
	go_roulette()

func _on_go_button_button_up() -> void:
	stop_roulette()




func obtener_segmento_apuntado() -> int:
	var numero_de_segmentos : int = match_info.roulette_info.r_segments.size()
	#print("Numero de segmentos: ", numero_de_segmentos)
	# 1. Obtener la rotación actual en Y y convertirla a grados positivos (0 a 360)
	var rotacion_y_grados = fposmod(rad_to_deg(roulette_rb.global_rotation.y), 360.0)
	
	# 2. Sincronizar con el desfase del shader (nuestro offset_shader era PI = 180 grados)
	# Si en el script anterior usaste '+ offset_shader', aquí lo restamos.
	var grados_corregidos = rotacion_y_grados - 180.0
	
	# 3. Sumar la posición de la flecha en el mundo
	grados_corregidos -= offset_flecha_grados
	
	# 4. Asegurar que el resultado final siga estando entre 0 y 360
	grados_corregidos = fposmod(grados_corregidos, 360.0)
	
	# 5. Calcular cuántos grados mide cada segmento
	var grados_por_segmento = 360.0 / numero_de_segmentos
	
	# 6. Dividir y aplicar 'floor' para obtener el ID del segmento (0, 1, 2...)
	var id_segmento = floor(grados_corregidos / grados_por_segmento)
	
	# Invertir el ID si el disco rota en sentido horario
	# (Dependiendo de si sumas o restas rotación, descomenta la línea de abajo si te da al revés)
	id_segmento = (numero_de_segmentos - 1) - id_segmento
	id_segmento = int(fposmod(id_segmento, numero_de_segmentos))
	
	return id_segmento
