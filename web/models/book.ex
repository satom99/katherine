defmodule Katherine.Model.Book do
  use Katherine.Model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "books" do
    field :name, :string
    field :description, :string

    many_to_many :authors, Author,
    [
      join_through: "authors_books",
      on_replace: :delete,
      on_delete: :delete_all
    ]
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert
  end

  def update(struct, params) do
    struct
    |> Repo.preload(:authors)
    |> changeset(params)
    |> Repo.update
  end

  defp changeset(struct, params) do
    struct
    |> cast(params, [:name, :description])
    |> put_assoc(:authors, parse_authors(struct, params))
    |> validate_length(:authors, min: 1)
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  defp parse_authors(struct, %{authors: nil}) do
    struct.authors
  end
  defp parse_authors(_struct, %{authors: authors}) do
    authors
    |> Enum.uniq
    |> Enum.map(&Author.get/1)
  end
end
