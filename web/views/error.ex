defmodule Katherine.ErrorView do
  use Phoenix.View, root: ""

  import Ecto.Changeset

  def render(path, params) do
    [code, format] = path
    |> String.split(".")

    reason = code
    |> String.to_integer
    |> Plug.Conn.Status.reason_phrase

    object = cond do
      changeset = params[:changeset] ->
        traverse(changeset)
      true ->
        %{message: "#{code}: #{reason}"}
    end

    cond do
      format == "json" ->
        object
      true ->
        reason
    end
  end

  defp traverse(changeset) do
    traverse_errors(
      changeset,
      fn {message, options} ->
        Enum.reduce(
          options, message,
          fn {key, value}, acc ->
            value = "#{inspect value}"
            String.replace(acc, "%{#{key}}", value)
          end
        )
      end
    )
  end
end
