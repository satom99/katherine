use Mix.Config

# Logger
config :logger, :console,
[
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
]

# Ecto
config :katherine, ecto_repos: [Katherine.Repo]
config :katherine, Katherine.Repo,
[
  hostname: "localhost",
  database: "katherine",
  username: "root",
  password: "",
  pool_size: 10
]

# Phoenix
config :phoenix, json_library: Jason
config :katherine, Katherine.Endpoint,
[
  http: [port: 4000],
  render_errors: [accepts: ~w(json html)],
  secret_key_base: "E9gK3vOpWyAjQ6RRCaCqM2GAWrvYIQaANJavpjdV4gmIWTo8fH8Y2uJDX7yUOt+W",
  check_origin: false,
  server: true
]
