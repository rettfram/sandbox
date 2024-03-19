uniform float uTime;
uniform vec2 uHover;
uniform float uHoverState;
uniform sampler2D uTexture;

varying float vNoise;
varying vec2 vUv;

void main() {
  vec2 newUv = vUv;

  float newHoverState = uHoverState;
  newHoverState = smoothstep(0.0, 1.0, (newHoverState*2.0+newUv.y-1.0));

  vec4 texture = mix (
    texture2D(uTexture, (newUv-0.5)*(1.0-newHoverState)+0.5),
    texture2D(uTexture, (newUv-0.5)*newHoverState+0.5),
    newHoverState
  );

  // newUv = vec2(newUv.x, newUv.y + 0.1*sin(newUv.x * 10.0 + uTime));
  // vec4 texture = texture2D(uTexture, newUv);

  gl_FragColor = texture;
  gl_FragColor.rgb += 0.1*vec3(vNoise);
}