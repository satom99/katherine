defmodule Katherine.Repo.Migrations.Book do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :string
    end
    create unique_index(:books, :name)
  end
end
