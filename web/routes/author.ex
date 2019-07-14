defmodule Katherine.Route.Author do
  use Katherine.Route

  plug :fetch, model: Author
  plug :authorize, except: [:show]

  def create(conn, params) do
    case Author.create(params) do
      {:ok, author} ->
        conn
        |> assign(:author, author)
        |> show(%{})
      {:error, changeset} ->
        error(conn, changeset)
    end
  end

  def update(conn, params) do
    author = conn.assigns.author
    case Author.update(author, params) do
      {:ok, author} ->
        conn
        |> assign(:author, author)
        |> show(%{})
      {:error, changeset} ->
        error(conn, changeset)
    end
  end

  def delete(conn, _params) do
    Author.delete(conn.assigns.author)
    close(conn, 204)
  end

  def show(conn, _params) do
    author = conn.assigns.author
    books = author
    |> Repo.preload(:books)
    |> Map.get(:books)
    |> Enum.map(
      fn book ->
        %{
          id: book.id,
          name: book.name,
          description: book.description
        }
      end
    )
    data = %{
      id: author.id,
      name: author.name,
      lastname: author.lastname,
      books: books
    }
    json(conn, data)
  end

  def can?(user, _action, _resources) do
    user.admin
  end
end
