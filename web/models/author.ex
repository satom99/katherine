defmodule Katherine.Model.Author do
  use Katherine.Model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "authors" do
    field :name, :string
    field :lastname, :string

    many_to_many :books, Book,
    [
      join_through: "authors_books",
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
    |> changeset(params)
    |> Repo.update
  end

  defp changeset(struct, params) do
    struct
    |> cast(params, [:name, :lastname])
    |> validate_required([:name, :lastname])
    |> unique_constraint(:name, name: :authors_name_lastname_index)
  end
end
