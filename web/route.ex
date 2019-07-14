defmodule Katherine.Route do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller
      use Paramus

      import Katherine.Helpers

      alias Katherine.Repo
      alias Katherine.Model.{User, Author, Book}
    end
  end
end
