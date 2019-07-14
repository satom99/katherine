defmodule Katherine.Token do
  import Plug.Conn

  alias Phoenix.Token
  alias Katherine.Endpoint
  alias Katherine.Model.User

  @age 86400*9000
  @salt "katherine"

  def sign(%User{id: uuid}) do
    Token.sign(Endpoint, @salt, uuid, max_age: @age)
  end

  def validate(conn) do
    token = conn
    |> get_req_header("authorization")
    |> List.first

    case Token.verify(Endpoint, @salt, token, max_age: @age) do
      {:ok, uuid} ->
        User.get(uuid)
      _other ->
        nil
    end
  end
end
