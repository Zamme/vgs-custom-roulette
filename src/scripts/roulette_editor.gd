class_name RouletteEditor
extends Node3D

@onready var roulette_scene : Node3D = %roulette_01
@onready var segments_props_vbox : VBoxContainer = %SegmentsPropsVBoxContainer
@onready var nom_line_edit : LineEdit = $EditorUIControl/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer3/NomLineEdit
@onready var descripcio_line_edit : LineEdit = $EditorUIControl/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer4/DescripcioLineEdit
@onready var segments_spinbox : SpinBox = $EditorUIControl/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/SegmentsSpinBox
@onready var radiodev_spinbox : SpinBox = $EditorUIControl/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer2/RadioDevSpinBox
@onready var fontsize_spinbox : SpinBox = $EditorUIControl/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer5/MidaFontSpinBox
@onready var load_roulette_popup : FileDialog = $EditorUIControl/LoadRoulettePopup
@onready var save_confirmation_dialog : ConfirmationDialog = $EditorUIControl/SaveConfirmationDialog
@onready var new_confirmation_dialog : ConfirmationDialog = $EditorUIControl/NewConfirmationDialog

var roulette_info_default: RouletteInfo = RouletteInfo.new("New Roulette", "This is a new roulette",
	[SegmentInfo.new("Segment 1", Color.RED), 
		SegmentInfo.new("Segment 2", Color.GREEN), 
		SegmentInfo.new("Segment 3", Color.BLUE)], 0.5)

var roulette_info : RouletteInfo

var segment_props_container : PackedScene = preload("res://src/editor/segment_props_container.tscn")
var labels_container_packedscene : PackedScene = preload("res://src/editor/labels_container.tscn")
var labels_container_instance : Node = null


func _ready() -> void:
	print("Roulette Editor Ready")
	Globals.roulete_editor_scene = self
	create_new_roulette()

func clean_vbox_children(vbox: VBoxContainer) -> void:
	for child in vbox.get_children():
		child.queue_free()

func create_new_roulette() -> void:
	print("New roulette created")
	roulette_info = roulette_info_default.clone()
	update_all_editor()

func load_roulette(_roulette_name : String) -> void:
	roulette_info = Globals.save_load_manager.load_roulette(_roulette_name)
	update_all_editor()
	#var _loaded_roulette : RouletteInfo = Globals.save_load_manager.load_roulette("Test Roulette")
	#_loaded_roulette.print_info()

func save_roulette() -> void:
	var _saved : bool = Globals.save_load_manager.save_roulette(roulette_info)
	print("Saved: " + str(_saved))

func update_roulette_info_labels() -> void:
	nom_line_edit.text = roulette_info.r_name
	descripcio_line_edit.text = roulette_info.r_description
	segments_spinbox.value = roulette_info.r_segments.size()
	radiodev_spinbox.value = roulette_info.r_radio_dev
	fontsize_spinbox.value = roulette_info.r_mida_font

func update_labels_container() -> void:
	if labels_container_instance:
		labels_container_instance.queue_free()
	labels_container_instance = labels_container_packedscene.instantiate()
	add_child(labels_container_instance)
	labels_container_instance.generar_textos_radiales(roulette_info.r_segments, roulette_info.r_radio_dev, roulette_info.r_mida_font)

func update_all_editor():
	update_segments_properties()
	roulette_scene.load_roulette(roulette_info)
	update_labels_container()
	update_roulette_info_labels()

func update_roulette_segments(new_segments: Array) -> void:
	roulette_info.r_segments = new_segments
	roulette_scene.load_roulette(roulette_info)
	update_labels_container()

func update_segments_properties() -> void:
	clean_vbox_children(segments_props_vbox)
	for i in range(roulette_info.r_segments.size()):
		var new_segment_props_container = segment_props_container.instantiate()
		segments_props_vbox.add_child(new_segment_props_container)
		new_segment_props_container.segment_lineedit.text = roulette_info.r_segments[i].s_name
		new_segment_props_container.segment_color.color = roulette_info.r_segments[i].s_color
		new_segment_props_container.segment_n = i

func _on_segments_spin_box_value_changed(value: float) -> void:
	print("Segments Spin Box Value Changed: ", value)
	var new_array = Array()
	for i in range(int(value)):
		if i < roulette_info.r_segments.size():
			new_array.append(roulette_info.r_segments[i])
		else:
			new_array.append(SegmentInfo.new("Segment " + str(i + 1), Color.from_hsv(float(i) / value, 1.0, 1.0)))
	update_roulette_segments(new_array)
	update_segments_properties()


func _on_radio_dev_spin_box_value_changed(value: float) -> void:
	roulette_info.r_radio_dev = value
	update_labels_container()


func _on_mida_font_spin_box_value_changed(value: float) -> void:
	roulette_info.r_mida_font = value
	update_labels_container()


func _on_opcions_menu_index_pressed(index: int) -> void:
	match index:
		0:
			new_confirmation_dialog.popup_centered()
		1:
			load_roulette_popup.exclusive = true
			load_roulette_popup.transient = true
			Globals.save_load_manager.check_roulettes_dir()
			if load_roulette_popup.root_subfolder == "":
				load_roulette_popup.root_subfolder = Globals.save_load_manager.ROULETTES_DIRNAME
			load_roulette_popup.popup_centered()
			#load_roulette()
		2:
			if Globals.save_load_manager.exists_roulette_file(roulette_info.r_name):
				save_confirmation_dialog.popup_centered()
			else:
				save_roulette()
		3:
			Globals.game_manager.load_main_menu()

func _on_nom_line_edit_text_changed(new_text: String) -> void:
	roulette_info.r_name = new_text

func _on_descripcio_line_edit_text_changed(new_text: String) -> void:
	roulette_info.r_description = new_text

func _on_load_roulette_popup_file_selected(path: String) -> void:
	var _roulette_name : String = path.get_basename().get_file()
	load_roulette(_roulette_name)

func _on_save_confirmation_dialog_confirmed() -> void:
	save_roulette()

func _on_new_confirmation_dialog_confirmed() -> void:
	create_new_roulette()
