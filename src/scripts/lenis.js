import Lenis from '@studio-freight/lenis'

export let scrollEvent = {}

const lenis = new Lenis()

lenis.on('scroll', event => scrollEvent = event)

const raf = time => {
  lenis.raf(time)
  requestAnimationFrame(raf)
}

requestAnimationFrame(raf)