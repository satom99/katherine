defmodule Katherine.Repo.Migrations.Author do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :lastname, :string
    end
    create unique_index(:authors, [:name, :lastname])
  end
end
