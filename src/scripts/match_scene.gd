class_name MatchScene extends Node3D


@onready var roulette_rb : MatchRoulette = $MatchRoulette

var match_info : MatchInfo = MatchInfo.new()

var labels_container_packedscene : PackedScene = preload("res://src/editor/labels_container.tscn")
var labels_container_instance : LabelsContainer = null


func _ready() -> void:
	Globals.match_scene = self
	new_match()

func new_match() -> void:
	match_info = MatchInfo.new()
	match_info.create_default_match()
	update_match_scene()

func update_labels_container() -> void:
	var roulette_info : RouletteInfo = match_info.roulette_info
	if labels_container_instance:
		labels_container_instance.queue_free()
	labels_container_instance = labels_container_packedscene.instantiate()
	add_child(labels_container_instance)
	labels_container_instance.generar_textos_radiales(roulette_info.r_segments, roulette_info.r_radio_dev, roulette_info.r_mida_font)
	labels_container_instance.global_position.y = 0.2

func update_match_scene() -> void:
	update_roulette()

func update_roulette() -> void:
	roulette_rb.update_roulette_object(match_info.roulette_info)
	update_labels_container()

func _on_match_menu_index_pressed(index: int) -> void:
	match index:
		0:
			new_match()
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
