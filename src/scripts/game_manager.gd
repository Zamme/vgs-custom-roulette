class_name GameManager extends Node


const ROULETTE_EDITOR_SCENE_PATH = "res://src/editor/roulette_editor.tscn"
const MAIN_MENU_SCENE_PATH = "res://src/ui/rm_main_menu_control.tscn"

enum InitType {None, MainMenu, RouletteEditor}
@export var current_init_type : InitType

var current_scene


func _ready() -> void:
	Globals.game_manager = self
	match current_init_type:
		InitType.None:
			load_main_menu()
		InitType.MainMenu:
			load_main_menu()
		InitType.RouletteEditor:
			load_roulette_editor()

func load_main_menu() -> void:
	unload_current_scene()
	current_scene = load(MAIN_MENU_SCENE_PATH).instantiate()
	add_child(current_scene)

func load_roulette_editor() -> void:
	unload_current_scene()
	current_scene = load(ROULETTE_EDITOR_SCENE_PATH).instantiate()
	add_child(current_scene)

func unload_current_scene() -> void:
	if current_scene:
		print("Unloading " + current_scene.name)
		current_scene.queue_free()
