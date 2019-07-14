defmodule Katherine.Endpoint do
  use Phoenix.Endpoint, otp_app: :katherine

  plug Plug.Logger
  plug Plug.RequestId
  plug Plug.Parsers,
  [
    parsers: [:json, :multipart, :urlencoded],
    json_decoder: Jason
  ]
  plug Katherine.Router
end
