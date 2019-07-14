defmodule Katherine.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :admin, :boolean
      add :username, :string
      add :password_hash, :string
    end
    create unique_index(:users, :username)
  end
end
