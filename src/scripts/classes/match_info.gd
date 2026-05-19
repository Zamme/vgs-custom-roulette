class_name MatchInfo


var match_name : String
var match_state : int # 0 : None, 1 : Begining, 2 : Playing, 3 : Finished
var match_order : int # 0 : Forward, 1 : Backward, 2 : Random

var roulette_info_default: RouletteInfo = RouletteInfo.new("New Roulette", "This is a new roulette",
	[SegmentInfo.new("Segment 1", Color.RED), 
		SegmentInfo.new("Segment 2", Color.GREEN), 
		SegmentInfo.new("Segment 3", Color.BLUE)], 0.5)

var game_info_default : GameInfo = GameInfo.new("Joc Nou", "Descripcio de joc nou", [PlayerInfo.new("Nom Jugador")])

var roulette_info : RouletteInfo
var game_info : GameInfo

func _init() -> void:
	pass

func create_match(_match_name : String, _match_order : int, _match_state : int, _roulette_info : RouletteInfo, _game_info : GameInfo) -> void:
	match_name = _match_name
	match_order = _match_order
	match_state = _match_state
	roulette_info = _roulette_info
	game_info = _game_info

func create_default_match() -> void:
	match_name = "New Match"
	roulette_info = roulette_info_default.clone()
	game_info = game_info_default.clone()
