float ring(vec2 uv, vec2 p, float r, float blur){
    float d1 = length(uv-p);
    float c1 = smoothstep(r, r-blur, d1);
    float r2 = r-.002;
    float d2 = length(uv-(p*+1.));
    float c2 = smoothstep(r2, r2-blur, d2);
    return c1-c2; 
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  	vec2 uv = fragCoord.xy / iResolution.xy;
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;
    vec3 col = vec3(0.);
    vec2 p1 = vec2(-.09, 0);
    vec2 p2 = vec2(.09, 0);
    float mask = .0;
    for(float i = .2; i > .0 ;  i-=.01){
        mask += ring(uv, p1, i, 0.001);
    } 
    for(float i = .2; i > .0 ;  i-=.01){
        mask += ring(uv, p2, i, 0.001);
    } 
    
    col = vec3(1., 0., 0.)*mask;
    fragColor = vec4(vec3(col), 1.0);
}