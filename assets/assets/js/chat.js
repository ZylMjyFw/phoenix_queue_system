// 引入 Phoenix Socket
import { Socket } from "phoenix";

// 创建 WebSocket 连接
let socket = new Socket("/socket", {params: {user_id: "123"}});
socket.connect();

// 监听 "room:lobby" 频道
let channel = socket.channel("room:lobby", {});

channel.join()
  .receive("ok", resp => { console.log("Connected to room:lobby", resp); 
})
  .receive("error", resp => { console.log("Unable to connect to 
room:lobby", resp); });

// 监听用户输入
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

