shader_type spatial;

uniform vec4 lines[16];
uniform int line_count;
uniform float line_thickness : hint_range(0.0, 0.2) = 0.10;
uniform vec4 color : source_color = vec4(0.0, 1.0, 0.0, 1.0);

float dist_to_line_segment(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

void fragment() {
    // Get the position in model space before screen transform
    vec3 model_pos = (inverse(VIEW_MATRIX * MODEL_MATRIX) * vec4(VERTEX, 1.0)).xyz;
    vec2 point = model_pos.xz;  // Using XZ instead of XY since that's our ground plane

    float min_dist = 9999.0;

    for(int i = 0; i < line_count; i++) {
        vec2 start = lines[i].xy;
        vec2 end = lines[i].zw;
        float d = dist_to_line_segment(point, start, end);
        min_dist = min(min_dist, d);
    }

    if (min_dist < line_thickness) {
        ALBEDO = color.rgb;
        EMISSION = color.rgb;
    } else {
        discard;
    }
}