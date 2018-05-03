
//iGlobalTime 
// iMouse
// iResolution

vec3 paint(vec2 uv) {
	float time=iGlobalTime*1.0;
	float i0=1.0;
	float i1=1.0;
	float i2=1.0;
	float i4=0.0;
	for(int s=0;s<7;s++)
	{
		vec2 r;
		r=vec2(cos(uv.y*i0-i4+time/i1),sin(uv.x*i0-i4+time/i1))/i2;
        r+=vec2(-r.y,r.x)*0.3;
		uv.xy+=r;
        
		i0*=1.93;
		i1*=1.15;
		i2*=1.7;
		i4+=0.05+0.1*time*i1;
	}
    float r=sin(uv.x-time)*0.5+0.5;
    float b=sin(uv.y+time)*0.5+0.5;
    float g=sin((uv.x+uv.y+sin(time*0.5))*0.5)*0.5+0.5;
	return vec3(r,g,b);
}

float Circle(vec2 uv, vec2 p, float r, float blur) {
	float d = length(uv - p);
	return smoothstep(r, r - blur, d);
}

void main( )
{
    
    float time=iGlobalTime*1.0;

	vec2 uv2 = gl_FragCoord.xy / iResolution.xy;
	uv2 -= 0.5;
	uv2.x *= (iResolution.x / iResolution.y) * sin(time);

	vec2 uv = (gl_FragCoord.xy / iResolution.xx-0.5)*8.0;
    vec2 uv0=uv;

	float circle1 = Circle(uv2, vec2(0, sin(time / 1.)) * 0.2, 0.2, abs(cos(time)) * 0.04);
	float circle2 = Circle(uv2, vec2(0, -sin(time / 1.)) * 0.2, 0.2, abs(cos(time)) * 0.04);
	
	float circle3 = Circle(uv2, vec2(sin(time / 1.), 0) * 0.2, 0.2, abs(cos(time)) * 0.04);
	float circle4 = Circle(uv2, vec2(-sin(time / 1.), 0) * 0.2, 0.2, abs(cos(time)) * 0.04);

	vec3 paint1 = paint(uv) * circle1;
	vec3 paint2 = paint(uv) * circle2;
	vec3 paint3 = paint(uv) * circle3;
	vec3 paint4 = paint(uv) * circle4;
	

	vec3 newPaint  = (paint1 + paint2) * (paint3 + paint4);

	vec3 col = vec3(1., 1., abs(cos(time))) - (newPaint * 100.);


	gl_FragColor = vec4(col, 1.0);
}