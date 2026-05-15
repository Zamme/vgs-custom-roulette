shader_type canvas_item;

uniform int segments = 8; // Número de rebanadas
uniform float separation = 0.01; // Grosor de la línea divisoria
uniform float inner_radius = 0.01; // Para hacer un "donut" (0.0 para círculo lleno)
uniform vec4 color1 : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 color2 : source_color = vec4(0.0, 0.0, 1.0, 1.0);

void fragment() {
    // Centrar coordenadas de 0.0 a 1.0 -> -0.5 a 0.5
    vec2 uv = UV - 0.5;
    float dist = length(uv);
    float angle = (atan(uv.y, uv.x) + PI) / (2.0 * PI); // Normalizado 0.0 a 1.0

    // Lógica de segmentación
    float segment_id = floor(angle * float(segments));
    float segment_fract = fract(angle * float(segments));

    // Crear la máscara del círculo (anillo)
    float circle_mask = smoothstep(0.5, 0.49, dist) * smoothstep(inner_radius, inner_radius + 0.01, dist);

    // Crear la separación (hueco entre segmentos)
    float gap_mask = smoothstep(separation, separation + 0.01, segment_fract) * 
                     smoothstep(1.0 - separation, 1.0 - separation - 0.01, segment_fract);

    // Alternar colores (puedes expandir esto a una paleta o textura)
    vec4 final_color = mix(color1, color2, mod(segment_id, 2.0));
    
    COLOR = vec4(final_color.rgb, circle_mask * gap_mask * final_color.a);
}