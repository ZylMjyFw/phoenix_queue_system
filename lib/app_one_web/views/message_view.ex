defmodule AppOneWeb.MessageView do
  use AppOneWeb, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, __MODULE__, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, __MODULE__, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id, content: message.content}
  end
end

