defmodule Katherine.Route.Book do
  use Katherine.Route

  plug :fetch, model: Book
  plug :authorize, except: [:show]

  @required [
    name: :string,
    authors: {{:array, :binary_id}, nil}
  ]
  @optional [
    description: :string
  ]
  def create(conn, %{name: name, description: description, authors: authors}) do
    params = %{
      name: name,
      description: description,
      authors: authors
    }
    case Book.create(params) do
      {:ok, book} ->
        conn
        |> assign(:book, book)
        |> show(%{})
      {:error, changeset} ->
        error(conn, changeset)
    end
  end

  @optional [
    name: :string,
    description: :string,
    authors: {{:array, :binary_id}, nil}
  ]
  def update(conn, %{name: name, description: description, authors: authors}) do
    book = conn.assigns.book
    params = %{
      name: name || book.name,
      description: description || book.description,
      authors: authors
    }
    case Book.update(book, params) do
      {:ok, book} ->
        conn
        |> assign(:book, book)
        |> show(%{})
      {:error, changeset} ->
        error(conn, changeset)
    end
  end

  def delete(conn, _params) do
    Book.delete(conn.assigns.book)
    close(conn, 204)
  end

  def show(conn, _params) do
    book = conn.assigns.book
    authors = book
    |> Repo.preload(:authors)
    |> Map.get(:authors)
    |> Enum.map(
      fn author ->
        %{
          id: author.id,
          name: author.name,
          lastname: author.lastname
        }
      end
    )
    data = %{
      id: book.id,
      name: book.name,
      description: book.description,
      authors: authors
    }
    json(conn, data)
  end

  def can?(user, _action, _resources) do
    user.admin
  end
end
