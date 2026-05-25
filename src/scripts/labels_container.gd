class_name LabelsContainer extends Node3D

@export var radio_texto: float = 0.3 # Distancia desde el centro al texto

var radio_dev : float = 0.5

func _ready():
	pass

func generar_textos(segmentos):
	# Limpiar textos previos si los hay
	for child in self.get_children():
		child.queue_free()
	
	for i in range(segmentos.size()):
		var label = Label3D.new()
		
		# 1. Contenido y Estilo
		label.text = segmentos[i].s_name if i < segmentos.size() else str(i)
		label.font_size = 42
		label.outline_size = 12
		label.outline_render_priority = 1
		label.render_priority = 2 # Asegura que se renderice encima de otros objetos
		# Importante: para que no se vea a través de las paredes si no quieres
		label.no_depth_test = false
		
		self.add_child(label)
		
		# 2. Posicionamiento (Trigonometría)
		# Calculamos el ángulo central de la rebanada (i + 0.5 para centrar)
		var angulo = (float(i) + 0.5) / segmentos.size() * TAU
		
		# En Godot 3D, el plano horizontal suele ser X y Z
		var x = cos(angulo) * radio_texto
		var z = sin(angulo) * radio_texto
		
		# 0.01 en Y para que esté justo encima del disco y no parpadee (Z-fighting)
		label.position = Vector3(x, 0.1, z)
		
		# 3. Rotación para que esté "acostado" sobre el segmento
		label.rotation_edit_mode = Node3D.ROTATION_EDIT_MODE_EULER
		label.rotation.x = deg_to_rad(-90) # Lo acostamos sobre el disco
		
		# Rotación Y: Hace que el texto apunte hacia afuera del círculo
		# Si prefieres que el texto siempre se lea horizontal, comenta la línea de abajo
		label.rotation.y = -angulo + deg_to_rad(-90)

func generar_textos_radiales(segmentos, _radio_dev: float = 0.5, mida_font: float = 22.0):
	radio_dev = _radio_dev
	var numero_de_segmentos = segmentos.size()
	for i in range(numero_de_segmentos):
		var label = Label3D.new()
		label.render_priority = 2 # Asegura que se renderice encima de otros objetos
		label.outline_render_priority = 1
		label.font_size = mida_font
		label.outline_size = int(mida_font/3)
		label.text = segmentos[i].s_name if i < segmentos.size() else str(i)
		label.no_depth_test = false
		
		# --- CONFIGURACIÓN DE ALINEACIÓN ---
		# "Left" hace que el inicio de la palabra sea el punto de pivote
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		self.add_child(label)
		
		# --- POSICIONAMIENTO ---
		var angulo_segmento = ((float(i) + radio_dev) / numero_de_segmentos * TAU) + PI
		#var angulo = (float(i) + 0.5) / numero_de_segmentos * TAU
		
		# El radio_interno es donde empezará a leerse la primera letra
		var x = cos(angulo_segmento) * radio_texto
		var z = sin(angulo_segmento) * radio_texto
		label.position = Vector3(x, 0.1, z) # 0.1 para evitar parpadeo con el disco
				
		# --- ROTACIÓN RADIAL ---
		label.rotation_edit_mode = Node3D.ROTATION_EDIT_MODE_EULER
		
		# 1. Lo acostamos sobre el disco
		label.rotation.x = deg_to_rad(-90) 
		
		# 2. Rotamos sobre el eje Y para que apunte hacia afuera
		# Usamos -angulo porque Godot rota en sentido horario en 3D
		label.rotation.y = -angulo_segmento
