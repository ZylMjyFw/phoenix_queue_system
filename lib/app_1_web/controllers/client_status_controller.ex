defmodule App1Web.ClientStatusController do
  use App1Web, :controller  # 确保这里使用 `App1Web`

  def client_ready(conn, _params) do
    json(conn, %{status: "ok"})
  end
end

