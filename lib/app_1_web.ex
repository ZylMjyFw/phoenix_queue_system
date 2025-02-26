defmodule App1Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: App1Web
      import Plug.Conn
      alias App1Web.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/app_1_web/templates",
        namespace: App1Web

      import Phoenix.Controller
      import App1Web.Router.Helpers
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

