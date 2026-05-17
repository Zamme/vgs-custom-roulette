class_name MatchRoulette extends Node3D


@onready var roulette_object : RouletteObject = $roulette_01


func _ready() -> void:
	pass # Replace with function body.

func update_roulette_object(_roulette_info : RouletteInfo) -> void:
	roulette_object.load_roulette(_roulette_info)
