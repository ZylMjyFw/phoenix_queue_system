defmodule AppOne.Repo do
  use Ecto.Repo,
    otp_app: :app_one,
    adapter: Ecto.Adapters.Postgres
end

