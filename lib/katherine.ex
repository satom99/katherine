defmodule Katherine do
  use Application

  alias Katherine.{Repo, Endpoint}

  def start(_type, _args) do
    children = [
      Repo,
      Endpoint
    ]
    options = [
      strategy: :one_for_one,
      name: __MODULE__
    ]
    Supervisor.start_link(children, options)
  end
end
