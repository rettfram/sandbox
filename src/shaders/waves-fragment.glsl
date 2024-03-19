uniform float uTime;
uniform vec2 uHover;
uniform float uHoverState;
uniform sampler2D uTexture;

varying float vNoise;
varying vec2 vUv;

void main() {
  vec2 newUv = vUv;

  // newUv = vec2(newUv.x, newUv.y + 0.1*sin(newUv.x * 10.0 + uTime));

  vec4 texture = texture2D(uTexture, newUv);

  gl_FragColor = texture;
  gl_FragColor.rgb += 0.1*vec3(vNoise);
}