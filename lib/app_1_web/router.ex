defmodule App1Web.Router do
  use App1Web, :router  # 这行必须存在，否则 `scope/3` 无法使用

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", App1Web do
    pipe_through :api  # 确保请求通过 API pipeline

    get "/client_ready", ClientStatusController, :client_ready
  end
end

