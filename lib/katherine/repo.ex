defmodule Katherine.Repo do
  use Ecto.Repo,
    otp_app: :katherine,
    adapter: Ecto.Adapters.MyXQL
end
