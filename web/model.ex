defmodule Katherine.Model do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias Katherine.Repo
      alias Katherine.Model.{User, Author, Book}

      defdelegate delete(struct), to: Repo

      def get(id), do: Repo.get(__MODULE__, id)
    end
  end
end
