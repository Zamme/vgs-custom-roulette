class_name PlayerEditingHBox extends HBoxContainer

@onready var order_label : Label = $OrderLabel
@onready var nom_jugador_lineedit : LineEdit = $NomJugadorLineEdit
@onready var up_button : Button = $UpButton
@onready var down_button : Button = $DownButton
@onready var delete_button : Button = $DeleteButton


func _ready() -> void:
	pass # Replace with function body.

func create_player(_order : int, _player_info : PlayerInfo):
	self.order_label.text = str(_order)
	self.nom_jugador_lineedit.text = _player_info.p_name

func delete_player() -> void:
	Globals.game_editor_scene.delete_player(int(self.order_label.text))

func modify_player_name(_text : String) -> void:
	Globals.game_editor_scene.modify_player_name(int(self.order_label.text), _text)

func move_player_down() -> void:
	Globals.game_editor_scene.move_player_down(int(self.order_label.text))

func move_player_up() -> void:
	Globals.game_editor_scene.move_player_up(int(self.order_label.text))

func _on_delete_button_button_up() -> void:
	delete_player()

func _on_up_button_button_up() -> void:
	move_player_up()

func _on_down_button_button_up() -> void:
	move_player_down()

func _on_nom_jugador_line_edit_text_changed(new_text: String) -> void:
	modify_player_name(new_text)
