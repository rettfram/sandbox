export const smoothScroll = node => {
  let start = 0
  let end = 0
  let easing = 0.1

  let lerp = (start, end, easing) => start * (1 - easing) + end * easing

  let animate = () => {
    end = window.pageYOffset || document.documentElement.scrollTop
    start = lerp(start, end, easing)
    
    document.body.style.height = `${node.scrollHeight}px`
    node.style.position = `fixed`
    node.style.transform = `translate(${start * 0}px, ${start * -1}px)`

    requestAnimationFrame(animate)
  }

  animate()
}