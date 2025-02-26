defmodule AppOne.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppOne.Repo,
      AppOneWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:app_one, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AppOne.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AppOne.Finch},
      # Start a worker by calling: AppOne.Worker.start_link(arg)
      # {AppOne.Worker, arg},
      # Start to serve requests, typically the last entry
      AppOneWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppOne.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppOneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
