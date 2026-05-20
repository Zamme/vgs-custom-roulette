class_name MatchInfo


var match_name : String
var match_state : int # 0 : None, 1 : Begining, 2 : Playing, 3 : Finished
var match_order : int # 0 : Forward, 1 : Backward, 2 : Random // NOT IN USE!
var match_turn : int # Player index pending to play
var match_results : Dictionary

var roulette_info_default: RouletteInfo = RouletteInfo.new("New Roulette", "This is a new roulette",
	[SegmentInfo.new("Segment 1", Color.RED), 
		SegmentInfo.new("Segment 2", Color.GREEN), 
		SegmentInfo.new("Segment 3", Color.BLUE)], 0.5)

var game_info_default : GameInfo = GameInfo.new("Joc Nou", "Descripcio de joc nou", [PlayerInfo.new("Nom Jugador")])

var roulette_info : RouletteInfo
var game_info : GameInfo

func _init() -> void:
	pass

func create_match(_match_name : String = "New Match", _match_order : int = 0, _match_results : Dictionary = Dictionary(), _match_state : int = 0, _roulette_info : RouletteInfo = RouletteInfo.new(), _game_info : GameInfo = GameInfo.new("New Game Info", "Desc Game Info", []), _match_turn : int = 0) -> void:
	match_name = _match_name
	match_order = _match_order
	match_state = _match_state
	roulette_info = _roulette_info
	game_info = _game_info
	match_results = _match_results
	match_turn = _match_turn

func create_default_match() -> void:
	match_name = "New Match"
	match_order = 0
	match_results = Dictionary()
	match_state = 0
	roulette_info = roulette_info_default.clone()
	game_info = game_info_default.clone()
	match_turn = 0
