defmodule AppOneWeb.PageController do
  use AppOneWeb, :controller

  def home(conn, _params) do
    text(conn, "index.html")
  end
end
