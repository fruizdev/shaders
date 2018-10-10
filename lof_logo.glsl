float circle(vec2 uv, vec2 p, float r, float blur){
    float d1 = length(uv-p);
    float c1 = smoothstep(r, r-blur, d1);
    float r2 = r-.02;
    float d2 = length(uv-(p*+1.));
    float c2 = smoothstep(r2, r2-blur, d2);
    return c1-c2; 
}

float band(float t, float start, float end, float blur){
    float step1 = smoothstep(start-blur, start+blur, t);
    float step2 = smoothstep(end+blur, end-blur, t);
    return step1*step2;   
} 

float rect(vec2 uv,float left, float right, float bottom, float top, float blur ){
    float band1 = band(uv.x, left, right, blur);
    float band2 = band(uv.y, bottom, top, blur);
    return band1*band2;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  	vec2 uv = fragCoord.xy / iResolution.xy;
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;
    vec3 col = vec3(0.);
    vec2 p1 = vec2(-.05, 0);
    vec2 p2 = vec2(.05, 0);
    float mask = circle(uv, p1, .2, 0.01);
    mask += circle(uv, p2, .2, 0.01);
    mask += rect(uv, -.13, .13, -.01, .01, .005);
    col = vec3(1., 0., 0.)*mask;
    fragColor = vec4(vec3(col), 1.0);
}