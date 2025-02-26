defmodule AppOneWeb.PageLive do
  use Phoenix.LiveView

  @impl true
  def mount(_params, _session, socket) do
    # 初始化 socket assigns，避免 KeyError
    {:ok, assign(socket, status: "waiting")}
  end

  @impl true
  def handle_event("mark_ready", _params, socket) do
    case AppOne.ClientReadyNotifier.notify_queue() do
      {:ok, _response} ->
        {:noreply, assign(socket, :status, "ready")}

      {:error, _reason} ->
        {:noreply, assign(socket, :status, "failed")}
    end
  end
end

