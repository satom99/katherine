defmodule Katherine.MixProject do
  use Mix.Project

  def project do
    [
      app: :katherine,
      version: "0.1.0",
      elixir: "~> 1.8",
      deps: deps(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      compilers: [:phoenix] ++ Mix.compilers,
      elixirc_paths: ["lib", "web"]
    ]
  end

  def application do
    [
      mod: {Katherine, []}
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.1"},
      {:phoenix_html, "~> 2.13"},
      {:phoenix, "~> 1.4"},
      {:myxql, "~> 0.2.6"},
      {:ecto_sql, "~> 3.1"},
      {:ecto, "~> 3.1"},
      {:bcrypt_elixir, "~> 2.0"},
      {:comeonin, "~> 5.1"},
      {:paramus, "~> 1.0"}
    ]
  end
end
