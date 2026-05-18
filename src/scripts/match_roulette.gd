class_name MatchRoulette extends RigidBody3D


@onready var roulette_object : RouletteObject = $roulette_01


func _ready() -> void:
	pass # Replace with function body.

func update_roulette_object(_roulette_info : RouletteInfo) -> void:
	roulette_object.load_roulette(_roulette_info)

func _physics_process(_delta: float) -> void:
	if Globals.match_scene.is_roulette_rolling:
		if angular_velocity == Vector3.ZERO:
			Globals.match_scene.roulette_stopped()
