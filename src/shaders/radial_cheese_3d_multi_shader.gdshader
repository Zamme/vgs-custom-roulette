shader_type spatial;
// 'unshaded' hace que el objeto ignore las luces y sombras del mundo
// 'cull_disabled' permite que se vea por ambos lados si es un plano
render_mode blend_mix, depth_draw_opaque, cull_disabled, unshaded, depth_prepass_alpha;

uniform int segments : hint_range(1, 64) = 8;
uniform float separation : hint_range(0.0, 0.1) = 0.02;
uniform float inner_radius : hint_range(0.0, 0.5) = 0.2;
uniform sampler2D palette : source_color, filter_nearest; 

void fragment() {
    vec2 uv = UV - 0.5;
    float dist = length(uv);
    
    // Coordenadas polares
    float angle = (atan(uv.y, uv.x) + PI) / (2.0 * PI);
    float segment_id = floor(angle * float(segments));
    float segment_fract = fract(angle * float(segments));

    // Máscaras de forma (Antialiasing con smoothstep)
    float ring_mask = smoothstep(0.5, 0.48, dist) * smoothstep(inner_radius, inner_radius + 0.01, dist);
    float gap_mask = smoothstep(separation, separation + 0.005, segment_fract) * 
                     smoothstep(1.0 - separation, 1.0 - separation - 0.005, segment_fract);
    
    // Color de la paleta
    float palette_uv = (segment_id + 0.5) / float(segments);
    vec4 sampled_color = texture(palette, vec2(palette_uv, 0.0));
    
    // En modo 'unshaded', ALBEDO define el color final directo
    ALBEDO = sampled_color.rgb;
    
    // Aplicamos la transparencia
    ALPHA = ring_mask * gap_mask * sampled_color.a;
}