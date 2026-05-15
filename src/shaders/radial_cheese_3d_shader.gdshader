shader_type spatial;

// Parámetros ajustables desde el Inspector
uniform int segments : hint_range(1, 32) = 8;
uniform float separation : hint_range(0.0, 0.2) = 0.02;
uniform float inner_radius : hint_range(0.0, 0.5) = 0.2;
uniform float outer_radius : hint_range(0.0, 0.5) = 0.48;
uniform vec4 color_a : source_color = vec4(1.0, 0.1, 0.1, 1.0);
uniform vec4 color_b : source_color = vec4(0.1, 0.1, 1.0, 1.0);
uniform float emission_strength : hint_range(0.0, 10.0) = 0.0;

void fragment() {
    // Usamos las coordenadas UV del modelo 3D
    // Generalmente van de 0 a 1 en las caras del objeto
    vec2 uv = UV - 0.5;
    float dist = length(uv);
    
    // Calculamos el ángulo en radianes y lo normalizamos a [0, 1]
    float angle = (atan(uv.y, uv.x) + PI) / (2.0 * PI);
    
    // Segmentación
    float segment_id = floor(angle * float(segments));
    float segment_fract = fract(angle * float(segments));
    
    // Máscaras de forma y separación
    // El smoothstep ayuda a que los bordes no se vean pixelados (anti-aliasing)
    float ring_mask = smoothstep(outer_radius, outer_radius - 0.01, dist) * 
                      smoothstep(inner_radius, inner_radius + 0.01, dist);
    
    float gap_mask = smoothstep(separation, separation + 0.01, segment_fract) * 
                     smoothstep(1.0 - separation, 1.0 - separation - 0.01, segment_fract);
    
    float final_mask = ring_mask * gap_mask;
    
    // Color final alternado
    vec4 color = mix(color_a, color_b, mod(segment_id, 2.0));
    
    // Aplicamos al canal ALBEDO (color base)
    ALBEDO = color.rgb;
    
    // Aplicamos la máscara al ALPHA para que lo que no es círculo sea transparente
    // Nota: Debes activar el modo de transparencia en el material
    ALPHA = final_mask * color.a;
    
    // Opcional: Hacer que brille
    EMISSION = color.rgb * emission_strength * final_mask;
}