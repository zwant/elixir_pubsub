defmodule ElixirPubsub.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_pubsub

  socket "/socket", ElixirPubsub.UserSocket

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug ElixirPubsub.Router
end
