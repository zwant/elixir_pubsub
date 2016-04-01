defmodule ElixirPubsub.Topic do
  def start_link(topic) do
    Agent.start_link(fn -> [] end, name: topic)
  end

  def push(topic, message) do
    Agent.update(topic, fn list -> [list|message] end)
  end

  def pop(topic) do
    Agent.get_and_update(topic, fn
      []    -> {:error, []}
      [h|t] -> {{:ok, t}, h}
    end)
  end
end
