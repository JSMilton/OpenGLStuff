
in vec3 position_eye, normal_eye;
in vec4 color;
in mat4 modelView;
out vec4 fragColor;

uniform mat4 viewMatrix;

// fixed point light properties
vec3 light_position_world = vec3 (20.0, 0.0, 0.0);
vec3 Ls = vec3 (1.0, 1.0, 1.0); // white specular colour
vec3 Ld = vec3 (0.8, 0.0, 0.0); // dull white diffuse light colour
vec3 La = vec3 (0.2, 0.2, 0.2); // grey ambient colour

// surface reflectance
vec3 Ks = vec3 (0.2, 0.2, 0.2); // fully reflect specular light
vec3 Kd = vec3 (0.5, 0.5, 0.5); // orange diffuse surface reflectance
vec3 Ka = vec3 (1.0, 1.0, 1.0); // fully reflect ambient light
float specular_exponent = 0.05f; // specular 'power'

void main (void)
{
    // ambient intensity
    vec3 Ia = La * Ka;
    
    vec3 EyeDirection_eye = vec3(0,0,0) - position_eye;
    vec3 light_position_eye = vec3(viewMatrix * vec4(light_position_world, 1.0)).xyz;
    vec3 light_direction_eye = light_position_eye + EyeDirection_eye;
    vec3 n = normalize(normal_eye);
    vec3 l = normalize(light_direction_eye);
    float dot_prod = dot (n, l);
    dot_prod = max (dot_prod, 0.0);
    vec3 Id = Ld * Kd * dot_prod; // final diffuse intensity
    
//    // raise light position to eye space
//    vec3 light_position_eye = vec3 (modelView * vec4 (light_position_world, 1.0));
//    vec3 distance_to_light_eye = light_position_eye - position_eye;
//    vec3 direction_to_light_eye = normalize (distance_to_light_eye);
//    float dot_prod = dot (direction_to_light_eye, normal_eye);
//    dot_prod = max (dot_prod, 0.0);
//    vec3 Id = Ld * Kd * dot_prod; // final diffuse intensity
//    
//    vec3 reflection_eye = reflect (-direction_to_light_eye, normal_eye);
//    vec3 surface_to_viewer_eye = normalize (-position_eye);
//    float dot_prod_specular = dot (reflection_eye, surface_to_viewer_eye);
//    dot_prod_specular = max (dot_prod_specular, 0.0);
//    float specular_factor = pow (dot_prod_specular, specular_exponent);
//    //vec3 Is = Ls * Ks * specular_factor; // final specular intensity
    
    //vec3 Id = vec3(0.0, 0.0, 0.0);
    // specular intensity
    vec3 Is = vec3 (0.0, 0.0, 0.0); // replace me later
    
    // final colour
    fragColor = vec4 (Is + Id + Ia, 1.0);
}