defmodule AppOne.ClientReadyNotifier do
  require Logger

  def notify_queue do
    url = "http://localhost:4000/api/client_ready"
    body = Jason.encode!(%{client_id: "client_1", status: "ready"})

    request =
      Finch.build(:post, url, [{"Content-Type", "application/json"}], body)

    case Finch.request(request, MyApp.Finch) do
      {:ok, %Finch.Response{status: 200, body: response_body}} ->
        Logger.info("Queue acknowledged: #{response_body}")
        {:ok, response_body}

      {:ok, %Finch.Response{status: status_code}} ->
        Logger.error("Failed to notify queue, status code: #{status_code}")
        {:error, status_code}

      {:error, reason} ->
        Logger.error("Error notifying queue: #{inspect(reason)}")
        {:error, reason}
    end
  end
end

