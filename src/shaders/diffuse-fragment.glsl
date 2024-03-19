uniform sampler2D tDiffuse;
uniform float uScrollSpeed;
varying vec2 vUv;

void main() {
  vec2 newUv = vUv;
  float area = smoothstep(0.1, 0.0, vUv.y) + smoothstep(0.9, 1.0, vUv.y);
  area = pow(area, 2.0);

  newUv.x -= (vUv.x - 0.5)*area*uScrollSpeed;
  
  gl_FragColor = texture2D(tDiffuse, newUv);
}