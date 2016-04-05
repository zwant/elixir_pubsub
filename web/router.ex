defmodule ElixirPubsub.Router do
  use ElixirPubsub.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirPubsub do
    pipe_through :api

    post "/topic/:topic", PublisherController, :new
    get "/topic/:topic", PublisherController, :get
  end
end
