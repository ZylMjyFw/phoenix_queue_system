defmodule AppOneWeb.MessageController do
  use AppOneWeb, :controller

  # 使用 Agent 存储消息
  @messages Agent.start_link(fn -> [] end, name: __MODULE__)

  # 1️⃣ 获取所有消息（GET /api/messages）
  def index(conn, _params) do
    messages = Agent.get(@messages, & &1)
    json(conn, %{data: messages})
  end

  # 2️⃣ 发送消息并转发给其他两个应用（POST /api/messages）
  def create(conn, %{"message" => message_params}) do
    # 存储消息到本地 Agent
    Agent.update(@messages, &([message_params | &1]))

    # 发送消息到 app_two 和 app_three
    send_message("http://localhost:4001/api/messages", message_params)
    send_message("http://localhost:4002/api/messages", message_params)

    json(conn, %{data: message_params})
  end

  # 3️⃣ 发送 HTTP 请求
  defp send_message(url, message) do
    Task.start(fn ->
      HTTPoison.post(url, Jason.encode!(%{"message" => message}), 
[{"Content-Type", "application/json"}])
    end)
  end
end

