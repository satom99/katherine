defmodule Katherine.Repo.Migrations.AuthorBook do
  use Ecto.Migration

  def change do
    create table(:authors_books, primary_key: false) do
      add :author_id, references(:authors, type: :uuid)
      add :book_id, references(:books, type: :uuid)
    end
    create unique_index(:authors_books, [:author_id, :book_id])
  end
end
