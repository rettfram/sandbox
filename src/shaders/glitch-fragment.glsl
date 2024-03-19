uniform sampler2D uTexture;
uniform float uTime;
uniform vec2 uHover;
uniform float uIntensity;

varying vec2 vUv;

void main() {
  vec2 uv = vUv;
  vec4 baseState = texture2D(uTexture, uv);

  if (uIntensity > 0.0) {
    float segment = floor(uv.y * 12.0); 
    float randomValue = fract(sin(segment * 12345.6789 + uIntensity) * 43758.5453); 
    vec2 offset = vec2(randomValue * 0.03, 0.0) * uIntensity;

    vec4 redGlitch = texture2D(uTexture, uv + offset);
    vec4 greenGlitch = texture2D(uTexture, uv - offset);
    vec4 blueGlitch = texture2D(uTexture, uv);

    if (mod(segment, 3.0) == 0.0) {
      gl_FragColor = vec4(redGlitch.r, greenGlitch.g, baseState.b, 1.0);
    } else if (mod(segment, 3.0) == 1.0) {
      gl_FragColor = vec4(baseState.r, greenGlitch.g, blueGlitch.b, 1.0);
    } else {
      gl_FragColor = vec4(redGlitch.r, baseState.g, blueGlitch.b, 1.0);
    }
  } else {
    gl_FragColor = baseState; 
  }
}