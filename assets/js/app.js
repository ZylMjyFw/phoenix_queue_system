// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import "./chat";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// 创建 WebSocket 连接
let socket = new Socket("/socket", {params: {user_id: "123"}});
socket.connect();

// 监听 "room:lobby" 频道
let channel = socket.channel("room:lobby", {});

channel.join()
  .receive("ok", resp => { console.log("Connected to room:lobby", resp); 
})
  .receive("error", resp => { console.log("Unable to connect to room:lobby", resp); });

// 监听消息输入框
document.getElementById("send-button").addEventListener("click", 
function() {
  let input = document.getElementById("message-input");
  channel.push("new_msg", {body: input.value});
  input.value = "";
});

// 监听服务器发送的新消息
channel.on("new_msg", payload => {
  let messagesContainer = document.getElementById("messages");
  let messageItem = document.createElement("p");
  messageItem.innerText = payload.body;
  messagesContainer.appendChild(messageItem);
});

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

