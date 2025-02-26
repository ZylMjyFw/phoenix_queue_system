defmodule App1.QueueManager do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  # **添加用户到队列**
  def add_user(user_id) do
    position = :ets.info(:user_queue, :size) + 1
    :ets.insert(:user_queue, {user_id, position})
  end

  # **获取用户排队位置**
  def get_queue_position(user_id) do
    case :ets.lookup(:user_queue, user_id) do
      [{_, position}] -> position
      _ -> nil
    end
  end

  # **移除队列中的用户**
  def remove_user(user_id) do
    :ets.delete(:user_queue, user_id)
  end

  # **获取当前所有排队用户**
  def get_all_users() do
    :ets.tab2list(:user_queue)
  end
end

