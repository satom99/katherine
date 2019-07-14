defmodule Katherine.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Katherine.Route do
    pipe_through :api

    resources "/auth", Auth, only: [:create]
    resources "/user", User, only: [:create, :index]

    resources "/author", Author, only: [:create, :show, :update, :delete]
    resources "/book", Book, only: [:create, :show, :update, :delete]
  end
end
