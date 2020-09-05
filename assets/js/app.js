import "../css/app.scss"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
liveSocket.connect()

window.addEventListener('click', e => {
  if (!e.target || e.target.nodeName !== 'A') return
  if (e.target.getAttribute('rel') !== 'external') return
  window.open(e.target.href)
  e.preventDefault()
  return false
})
