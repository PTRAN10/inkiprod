# --------------------
# HELPERS
# --------------------
window.requestAnimFrame = do -> window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or ( callback ) -> window.setTimeout callback, 1000/60

animate = ( callback, duration = 300, easing = (t) -> t ) ->
  start = ( new Date ).getTime()
  do animation = ->
    t = easing ( ( new Date ).getTime()-start )/duration
    if t <= 1 then requestAnimFrame animation else t = 1
    callback t

smoothScroll = ( element, duration = 300 ) ->
  current = document.documentElement.scrollTop or document.body.scrollTop
  target = element.getBoundingClientRect().top-window.innerHeight*.05
  animate ( (t) -> window.scrollTo 0, current+target*t ), duration, (t) -> (--t)*t*t+1 # easeOutCubic



# --------------------
# ANCHORS
# --------------------
do ->
  for link in document.querySelectorAll 'a' when not link.classList.contains('js-prevent')
    if not link.href.match location.host then link.setAttribute 'target', '_blank'
    else if link.href.match '#'
      link.addEventListener 'click', (e) ->
        do e.preventDefault
        smoothScroll document.querySelector(@href.replace /^[^\#]*/, ''), 800
