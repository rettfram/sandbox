uniform sampler2D uTexture;
uniform float uTime;
uniform vec2 uHover;
uniform float uIntensity;

varying vec2 vUv;

void main() {
  vec2 uv = vUv;
  float wave1 = sin(uv.x * 10.0 + uTime * 0.5 + uHover.x * 5.0) * uIntensity * 0.01;
  float wave2 = sin(uv.y * 12.0 + uTime * 0.8 + uHover.y * 4.0) * uIntensity * 0.01;
  float wave3 = cos(uv.x * 8.0 + uTime * 0.5 + uHover.x * 3.0) * uIntensity * 0.01;
  float wave4 = cos(uv.y * 9.0 + uTime * 0.7 + uHover.y * 3.5) * uIntensity * 0.01;

  uv.y += wave1 + wave2;
  uv.x += wave3 + wave4;
  
  gl_FragColor = texture2D(uTexture, uv);
}