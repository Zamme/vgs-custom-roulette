extends Node3D

@onready var roulette_inner = %Roulete_001

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func load_roulette(roulette_info):
	print("Loading Roulette: ", roulette_info.r_name)
	var segments = roulette_info.r_segments
	var segment_count = segments.size()
	var roulette_material = roulette_inner.get_surface_override_material(0)
	if roulette_material is ShaderMaterial:
		print("Setting segment count to: ", segment_count)
		roulette_material.set_shader_parameter("segments", segment_count)
		var palette = roulette_material.get_shader_parameter("palette")
		var new_gradient = Gradient.new()
		new_gradient.interpolation_mode = Gradient.GRADIENT_INTERPOLATE_CONSTANT
		for i in range(segment_count):
			var segment_color = segments[i].s_color
			new_gradient.add_point(float(i) / segment_count, segment_color)
		palette.set("gradient", new_gradient)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
