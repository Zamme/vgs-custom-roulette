class_name GameInfo

var g_name: String
var g_description : String
var g_players : Array

func _init(_name: String = "", _description : String = "", _players : Array = []) -> void:
	self.g_name = _name
	self.g_description = _description
	self.g_players = _players

func clone() -> GameInfo:
	var _game_info : GameInfo = GameInfo.new()
	_game_info.g_name = g_name
	_game_info.g_description = g_description
	_game_info.g_players = g_players.duplicate()
	return _game_info
