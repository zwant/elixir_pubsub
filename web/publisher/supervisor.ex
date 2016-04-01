defmodule ElixirPubsub.TopicAndRegistrySupervisor do
    use Supervisor

    def start_link(opts \\ []) do
        Supervisor.start_link(__MODULE__, :ok, opts)
    end

    def init(:ok) do
        children = [
            supervisor(ElixirPubsub.Topic.Supervisor, [[name: ElixirPubsub.Topic.Supervisor]]),
            worker(ElixirPubsub.TopicRegistry, [])
        ]

        supervise(children, strategy: :one_for_all)
    end
end

defmodule ElixirPubsub.Topic.Supervisor do
    use Supervisor

    def start_link(opts \\ []) do
        Supervisor.start_link(__MODULE__, :ok, opts)
    end

    def start_topic do
        Supervisor.start_child(ElixirPubsub.Topic.Supervisor, [])
    end

    def init(:ok) do
        children = [
            worker(ElixirPubsub.Topic, [], restart: :temporary)
        ]

        supervise(children, strategy: :simple_one_for_one)
    end
end
