defmodule App1.Application do
  use Application

  def start(_type, _args) do
    # **创建 ETS 表（全局存储队列）**
    :ets.new(:user_queue, [:ordered_set, :public, :named_table])

    children = [
      App1.QueueManager,  # **队列管理进程**
      App1Web.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

