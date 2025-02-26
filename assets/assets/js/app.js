// 引入 Phoenix 相关模块
import {Socket} from "phoenix";
import {LiveSocket} from "phoenix_live_view";
import topbar from "../vendor/topbar";
import "phoenix_html";
import "./chat";
// 获取 CSRF 令牌
let csrfToken = 
document.querySelector("meta[name='csrf-token']").getAttribute("content");

// 初始化 LiveSocket
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken} });

// 配置 topbar 进度条
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"});
window.addEventListener("phx:page-loading-start", _info => 
topbar.show(300));
window.addEventListener("phx:page-loading-stop", _info => topbar.hide());

// 连接 LiveView
liveSocket.connect();
window.liveSocket = liveSocket;

// 创建 WebSocket 连接
let socket = new Socket("/socket", {params: {user_id: "123"}});
socket.connect();

// 监听 "room:lobby" 频道
let channel = socket.channel("room:lobby", {});

channel.join()
  receive("ok", resp => { console.log("Connected to room:lobby", resp),
  receive("error", resp => { console.log("Unable to connect to room:lobby", resp);

// 监听消息输入框
document.getElementById("send-button").addEventListener("click", 
function() {
  let input = document.getElementById("message-input");
  channel.push("new_msg", {body: input.value});
  input.value = "";
});

// 监听服务器发送的消息
channel.on("new_msg", payload => {
  let messagesContainer = document.getElementById("messages");
  let messageItem = document.createElement("p");
  messageItem.innerText = payload.body;
  messagesContainer.appendChild(messageItem);
});
});
