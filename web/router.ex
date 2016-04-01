defmodule ElixirPubsub.Router do
  use ElixirPubsub.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirPubsub do
    pipe_through :api

    post "/publish/:topic", PublisherController, :new
  end
end
