uniform sampler2D uTexture;
uniform float uTime;
uniform vec2 uHover;
uniform float uIntensity;

varying vec2 vUv;

void main() {
  vec2 prevHover = uHover * 2.0;

  vec2 gridUV = floor(vUv * vec2(10.0, 10.0)) / vec2(10.0, 10.0);
  vec2 centerOfPixel = gridUV + vec2(1.0/10.0, 1.0/10.0);
  float pixelDistanceToMouse = length(centerOfPixel - uHover);
  float strength = smoothstep(0.5, 0.0, pixelDistanceToMouse);
  vec2 uv = vUv - strength * -(uHover - prevHover) * uIntensity * 0.1;

  vec4 colorR = texture2D(uTexture, uv + vec2(uIntensity * 0.01, 0.0));
  vec4 colorG = texture2D(uTexture, uv);
  vec4 colorB = texture2D(uTexture, uv - vec2(uIntensity * 0.01, 0.0));

  gl_FragColor = vec4(colorR.r, colorG.g, colorB.b, 1.0);
}