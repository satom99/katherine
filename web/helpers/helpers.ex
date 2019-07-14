defmodule Katherine.Helpers do
  import Phoenix.Controller
  import Plug.Conn

  alias Ecto.UUID
  alias Katherine.ErrorView
  alias Katherine.Token

  def close(conn, 204) do
    conn
    |> send_resp(204, "")
    |> halt
  end
  def close(conn, code) do
    conn
    |> put_status(code)
    |> put_view(ErrorView)
    |> render(:"#{code}")
    |> halt
  end

  def error(conn, changeset) do
    conn
    |> put_status(400)
    |> put_view(ErrorView)
    |> render(:"400", changeset: changeset)
    |> halt
  end

  def fetch(conn, params) do
    model = params[:model]
    cond do
      id = conn.params["id"] ->
        name = model
        |> Module.split
        |> List.last
        |> String.downcase
        |> String.to_atom

        cond do
          UUID.dump(id) == :error ->
            close(conn, 400)
          object = model.get(id) ->
            assign(conn, name, object)
          true ->
            close(conn, 404)
        end
      true ->
        conn
    end
  end

  def authorize(conn, params) do
    cond do
      action_exempt?(conn, params) ->
        conn
      user = Token.validate(conn) ->
        action = action_name(conn)
        module = controller_module(conn)
        cond do
          module.can?(user, action, conn.assigns) ->
            assign(conn, :user, user)
          true ->
            close(conn, 403)
        end
      true ->
        close(conn, 401)
    end
  end

  defp action_exempt?(conn, params) do
    action = action_name(conn)
    cond do
      only = params[:only] ->
        !(action in only)
      except = params[:except] ->
        action in except
      true ->
        false
    end
  end
end
