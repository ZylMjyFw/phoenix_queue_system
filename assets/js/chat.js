import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {}})
socket.connect()

let channel = socket.channel("chat:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

function sendMessage() {
    let input = document.getElementById("message-input");
    if (input.value.trim() !== "") {
        channel.push("new_msg", {body: input.value});
        input.value = "";
    }
}

channel.on("new_msg", payload => {
    let messages = document.getElementById("messages");
    let messageItem = document.createElement("p");
    messageItem.innerText = payload.body;
    messages.appendChild(messageItem);
});

