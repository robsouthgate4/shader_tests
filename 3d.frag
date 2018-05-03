
//iGlobalTime 
// iMouse
// iResolution

uniform float u_time;
uniform vec2 u_resolution;

float DistLine(vec3 ro, vec3 rd, vec3 p) {
    return length(cross(p - ro, rd)) / length(rd);
}

float DrawPoint(vec3 ro, vec3 rd, vec3 p) {
    float d = DistLine(ro, rd, p);
    d = smoothstep(0.06, 0.05, d);
    return d;
}

void main( )
{
    
    float time=u_time*2.0;

	vec2 uv = gl_FragCoord.xy / u_resolution.xy;
	uv -= .5;
	uv.x *= u_resolution.x / u_resolution.y;

    vec3 ro = vec3(0.0, 0.0, -3.0);
    vec3 rd = vec3(uv.x, uv.y, -2.) - ro;

    // vec3 p = vec3(sin(time), 0., 4. + cos(time));
    // vec3 p2 = vec3(-sin(time / 2.0), 0., 3. + -cos(time));
    // vec3 p3 = vec3(-sin(time), 0., 1. + -cos(time));

    float d = 0.;

    d += DrawPoint(ro, rd, vec3(0., 0., 0.));
    d += DrawPoint(ro, rd, vec3(0., 0, 1.));
    d += DrawPoint(ro, rd, vec3(0., 1., 0.));
    d += DrawPoint(ro, rd, vec3(0., 1., 1.));
    d += DrawPoint(ro, rd, vec3(1., 0., 0.));
    d += DrawPoint(ro, rd, vec3(1., 0., 1.));
    d += DrawPoint(ro, rd, vec3(1., 1., 0.));
    d += DrawPoint(ro, rd, vec3(1., 1., 1.));
    

	gl_FragColor = vec4(d);
}