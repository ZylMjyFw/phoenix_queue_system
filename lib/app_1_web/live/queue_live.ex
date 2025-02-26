defmodule App1Web.QueueLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, position: nil, queue: 
App1.QueueManager.get_all_users())}
  end

  # **用户点击 "加入队列" 按钮**
  def handle_event("join_queue", %{"user_id" => user_id}, socket) do
    App1.QueueManager.add_user(user_id)
    position = App1.QueueManager.get_queue_position(user_id)
    queue = App1.QueueManager.get_all_users()

    {:noreply, assign(socket, position: position, queue: queue)}
  end
end

