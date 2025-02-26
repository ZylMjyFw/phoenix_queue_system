defmodule AppOne.Messages do
  alias AppOne.Repo
  alias AppOne.Messages.Message

  def list_messages do
    Repo.all(Message)
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end
end

