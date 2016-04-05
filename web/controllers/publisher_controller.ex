defmodule ElixirPubsub.PublisherController do
  use ElixirPubsub.Web, :controller

  def new(conn, %{"topic" => topic, "message" => message}) do
    {:ok, topic_agent} = ElixirPubsub.TopicRegistry.create(topic)
    ElixirPubsub.Topic.push(topic_agent, message)
    json conn, %{topic: topic, message: message}
  end

  def get(conn, %{"topic" => topic}) do
    {:ok, topic_agent} = ElixirPubsub.TopicRegistry.lookup(topic)
    case ElixirPubsub.Topic.pop(topic_agent) do
      {:ok, message} -> conn |> json(message)
      :error -> conn |> send_resp(404, "Topic is empty")
    end

  end
end
