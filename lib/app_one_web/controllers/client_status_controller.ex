defmodule AppOneWeb.ClientStatusController do
  use AppOneWeb, :controller

  def client_ready(conn, _params) do
    json(conn, %{status: "ready"})
  end
end

