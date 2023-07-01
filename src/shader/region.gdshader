shader_type canvas_item;

void fragment()
{
    // Calculate the gradient value based on the fragment's Y coordinate
    float gradient = SCREEN_UV.y;
    
    // Set the output color to the gradient value as a red-to-yellow color
    COLOR.rgb = vec3(1.0, gradient, 0.0);
    COLOR.a = 0.5;
}