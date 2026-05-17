class_name MatchInfo


var roulette_info_default: RouletteInfo = RouletteInfo.new("New Roulette", "This is a new roulette",
	[SegmentInfo.new("Segment 1", Color.RED), 
		SegmentInfo.new("Segment 2", Color.GREEN), 
		SegmentInfo.new("Segment 3", Color.BLUE)], 0.5)

var game_info_default : GameInfo = GameInfo.new("Joc Nou", "Descripcio de joc nou", [PlayerInfo.new("Nom Jugador")])

var roulette_info : RouletteInfo
var game_info : GameInfo

func _init() -> void:
	pass

func create_match(_roulette_info : RouletteInfo, _game_info : GameInfo) -> void:
	roulette_info = _roulette_info
	game_info = _game_info

func create_default_match() -> void:
	roulette_info = roulette_info_default.clone()
	game_info = game_info_default.clone()
