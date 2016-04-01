defmodule ElixirPubsub.PublisherController do
  use ElixirPubsub.Web, :controller

  def new(conn, %{"topic" => topic}) do
    ElixirPubsub.TopicRegistry.create(:lol)

    json conn, %{topic: topic}
  end
end
