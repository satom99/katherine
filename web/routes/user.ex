defmodule Katherine.Route.User do
  use Katherine.Route

  plug :authorize, only: [:index]

  def create(conn, params) do
    case User.create(params) do
      {:ok, _user} ->
        close(conn, 204)
      {:error, changeset} ->
        error(conn, changeset)
    end
  end

  def index(conn, _params) do
    user = conn.assigns.user
    data = %{
      id: user.id,
      username: user.username
    }
    json(conn, data)
  end

  def can?(_user, :index, _resources) do
    true
  end
end
