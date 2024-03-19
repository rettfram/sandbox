uniform sampler2D tDiffuse;
uniform float uScrollSpeed;
uniform float uIntensity;
varying vec2 vUv;

void main() {
  vec2 newUv = vUv;
  float area = smoothstep(0.5, 0.0, vUv.x) + smoothstep(0.5, 1.0, vUv.x);
  area = pow(area, 2.0);

  vec2 uv = vUv;
  vec4 baseState = texture2D(tDiffuse, uv);

  if (uIntensity > 0.0) {
    float segment = floor(uv.y * 64.0); 
    float randomValue = fract(sin(segment * 12345.6789 + uIntensity) * 43758.5453); 
    vec2 offset = vec2(randomValue * 0.01, 0.0) * uIntensity;

    vec4 redGlitch = texture2D(tDiffuse, uv);
    vec4 greenGlitch = texture2D(tDiffuse, uv + offset * uScrollSpeed * 0.1);
    vec4 blueGlitch = texture2D(tDiffuse, uv - offset * uScrollSpeed * 0.1);

    if (mod(segment, 3.0) == 0.0) {
      gl_FragColor = baseState;
      gl_FragColor -= vec4(redGlitch.r * area, greenGlitch.g * area, baseState.b * area, 1.0);
    } else if (mod(segment, 3.0) == 1.0) {
      gl_FragColor = baseState;
      gl_FragColor -= vec4(redGlitch.r * area, greenGlitch.g * area, blueGlitch.b * area, 1.0);
    } else {
      gl_FragColor = baseState;
      gl_FragColor -= vec4(redGlitch.r * area, baseState.g * area, blueGlitch.b * area, 1.0);
    }
  } else {
    gl_FragColor = baseState; 
  }





  // gl_FragColor = texture2D(tDiffuse, newUv);
  // gl_FragColor = vec4(1.0 * area, 0.0, 0.0, 1.0);
}