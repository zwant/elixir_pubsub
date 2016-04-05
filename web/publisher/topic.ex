defmodule ElixirPubsub.Topic do
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def push(topic, message) do
    Agent.update(topic, fn
      []  -> [message]
      list -> [list|message] end)
  end

  def pop(topic) do
    Agent.get_and_update(topic, fn
      []    -> {:error, []}
      [t] -> {{:ok, t}, []}
      [h|t] -> {{:ok, t}, h}
    end)
  end
end
