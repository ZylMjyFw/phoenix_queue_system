defmodule AppOneWeb.UserSocket do
  use Phoenix.Socket
  channel "chat:lobby", AppOneWeb.ChatChannel

  ## Channels
  # channel "room:*", AppOneWeb.RoomChannel

  ## Transports
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end

