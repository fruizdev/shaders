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
    
    vec3 col = vec3(0);
    float mask = 0.;
    float x = uv.x;
    float y = uv.y;
    
    mask =  rect(uv, -.4+y*.4, -.2+y*.4, -.3-x*.4, .3-x*.4, .001);
    mask += rect(uv, -.1+y*.4, .1+y*.4, -.3-x*.4, .3-x*.4, .001);
    mask += rect(uv, .2+y*.4,   .4+y*.4, -.3-x*.4, .3-x*.4, .001);
   
    col = vec3(1., 1.+y*.2, 1.)*mask;
    
    fragColor = vec4(col, 1.0);
}