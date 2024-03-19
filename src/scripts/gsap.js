import { gsap as greenSock } from 'gsap'
    
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { Flip } from 'gsap/Flip'
import { Observer } from 'gsap/Observer'
import { ScrollToPlugin } from 'gsap/ScrollToPlugin'
import { Draggable } from 'gsap/Draggable'
import { MotionPathPlugin } from 'gsap/MotionPathPlugin'
import { EaselPlugin } from 'gsap/EaselPlugin'
import { PixiPlugin } from 'gsap/PixiPlugin'
import { TextPlugin } from 'gsap/TextPlugin'


greenSock.registerPlugin(ScrollTrigger)

export const gsap = greenSock