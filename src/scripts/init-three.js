import { scrollEvent } from '../scripts/lenis'
import * as THREE from 'three'
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
import * as dat from 'dat.gui'

import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer.js'
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass.js'
import { ShaderPass } from 'three/examples/jsm/postprocessing/ShaderPass.js'
import { OutputPass } from 'three/examples/jsm/postprocessing/OutputPass.js'

import fragmentShader from '../shaders/diffuse-fragment.glsl'
import vertexShader from '../shaders/diffuse-vertex.glsl'

export const initThree = node => {
  // renderer
  const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
  node.appendChild(renderer.domElement)
  
  // camera
  const camera = new THREE.PerspectiveCamera(60, innerWidth / innerHeight, 0.001, 1000)
  
  // scene
  const scene = new THREE.Scene()
  // scene.fog = new THREE.FogExp2(0x000000, 0.01)

  // raycaster
  const raycaster = new THREE.Raycaster()

  // mouse
  const mouse = new THREE.Vector2()
  
  // gltfloader
  const gltfloader = new GLTFLoader()
  
  // control
  // const control = new OrbitControls(camera, renderer.domElement)
  // control.enableDamping = true
  
  // debug
  // const gui = new dat.GUI()
  
  // resize
  const resize = event => {
    const { offsetWidth, offsetHeight } = node

    renderer.setSize(offsetWidth, offsetHeight)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

    camera.aspect = offsetWidth / offsetHeight
    camera.position.z = offsetHeight / (2 * Math.tan(camera.fov * (Math.PI / 180) / 2)) | 0
    camera.updateProjectionMatrix()

    if (scene.children.length) {
      const currentScroll = scrollEvent.actualScroll
      scrollTo(0, 0)
      scene.children.forEach(object => {
        if (object.userData.html && object.geometry.type === "PlaneGeometry") {
          let { top, left, width, height } = object.userData.html.getBoundingClientRect()
          object.position.x = left - offsetWidth / 2 + width / 2
          object.position.y = -top + offsetHeight / 2 - height / 2
          object.geometry = new THREE.PlaneGeometry(width, height, 10, 10)
        }
      })
      scrollTo(0, currentScroll)
    }
  }
  
  // scroll event
  const scroll = event => {
    camera.position.y = (-scrollEvent.actualScroll - scrollEvent.velocity) | 0
  }

  // mousemove event
  const mousemove = event => {
    const { offsetWidth, offsetHeight } = node
    mouse.x = (event.clientX / offsetWidth) * 2 - 1
    mouse.y = -(event.clientY / offsetHeight) * 2 + 1
  }

  // composer
  resize(node)
  const effectComposer = new EffectComposer(renderer)
  const renderPass = new RenderPass(scene, camera)
  effectComposer.addPass(renderPass)

  return { renderer, scene, camera, raycaster, mouse, gltfloader, effectComposer, resize, scroll, mousemove }
}