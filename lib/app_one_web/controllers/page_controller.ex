defmodule AppOneWeb.PageController do
  use AppOneWeb, :controller

  def home(conn, _params) do
    text(conn, "Hello, World!")
  end
end
