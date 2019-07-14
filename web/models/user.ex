defmodule Katherine.Model.User do
  use Katherine.Model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :admin, :boolean
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
  end

  def create(params) do
    %__MODULE__{}
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:password, min: 8)
    |> unique_constraint(:username)
    |> password_hash
    |> Repo.insert
  end

  def login(username, password) do
    __MODULE__
    |> Repo.get_by(username: username)
    |> case do
      nil -> Bcrypt.no_user_verify()
      user -> Bcrypt.check_pass(user, password)
    end
  end

  defp password_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end
  defp password_hash(changeset), do: changeset
end
