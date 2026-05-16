class_name RM_MainMenu_Control extends Control


func _ready() -> void:
	Globals.main_menu = self

func _on_crear_ruleta_button_button_up() -> void:
	Globals.game_manager.load_roulette_editor()

func _on_editor_jocs_button_button_up() -> void:
	Globals.game_manager.load_game_editor()

func _on_jugar_button_button_up() -> void:
	pass # Replace with function body.
