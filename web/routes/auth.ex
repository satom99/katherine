defmodule Katherine.Route.Auth do
  use Katherine.Route

  alias Katherine.Token

  @required [
    username: :string,
    password: :string
  ]
  def create(conn, %{username: username, password: password}) do
    case User.login(username, password) do
      {:ok, user} ->
        data = %{token: Token.sign(user)}
        json(conn, data)
      _error ->
        close(conn, 403)
    end
  end
end
