defmodule ElixirPubsub.TopicRegistry do
  @name ElixirPubsub.TopicRegistry

  def start_link do
    Agent.start_link(fn -> Map.new end, name: @name)
  end

  def lookup(topic) do
    Agent.get(@name, fn dict ->
      Map.fetch(dict, topic)
    end)
  end

  def create(topic) do
    result = Agent.get(@name, fn dict -> Map.fetch(dict, topic) end)
    case result do
      :error ->
        {:ok, topic_agent} = ElixirPubsub.Topic.Supervisor.start_topic
        Agent.update(@name, fn dict -> Map.put(dict, topic, topic_agent) end)
        {:ok, topic_agent}
      {:ok, value} ->
        {:ok, value}
    end
  end
  #
  # def push(topic, message) do
  #   Agent.update(topic, fn list -> [list|message] end)
  # end
  #
  # def pop(topic) do
  #   Agent.get_and_update(topic, fn
  #     []    -> {:error, []}
  #     [h|t] -> {{:ok, t}, h}
  #   end)
  # end
  #
  #   def handle_call({:lookup, name}, _from, state) do
  #       {:reply, HashDict.fetch(state.names, name), state}
  #   end
  #
  #   def handle_call(:stop, _from, state) do
  #       {:stop, :normal, :ok, state}
  #   end
  #
  #   def handle_cast({:create, name}, state) do
  #       if HashDict.has_key?(state.names, name) do
  #           {:noreply, state}
  #       else
  #           {:ok, bucket_pid} = ElixirPubsub.Topic.Supervisor.start_bucket(state.topics)
  #           ref = Process.monitor(bucket_pid)
  #           refs2 = HashDict.put(state.refs, ref, name)
  #           names2 = HashDict.put(state.names, name, bucket_pid)
  #           GenEvent.sync_notify(state.events, {:create, name, bucket_pid})
  #           {:noreply, %{state | names: names2, refs: refs2}}
  #       end
  #   end
  #
  #   def handle_info({:DOWN, ref, :process, pid, _reason}, state) do
  #       name = HashDict.get(state.refs, ref)
  #       refs2 = HashDict.delete(state.refs, ref)
  #       names2 = HashDict.delete(state.names, name)
  #       GenEvent.sync_notify(state.events, {:exit, name, pid})
  #       {:noreply, %{state | names: names2, refs: refs2}}
  #   end
  #
  #   def handle_info(_msg, state) do
  #       {:noreply, state}
  #   end
  #
  #   def terminate(_reason, _state) do
  #       :ok
  #   end
end
