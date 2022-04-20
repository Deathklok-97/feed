defmodule DynamicWorker do
  use GenServer

  @registry :process_registry

  @initial_data [{:siblings, nil}, {:attributes, nil}, {:images, nil}]

  def start_link(name) do
    IO.puts "starting child #{name}"
    GenServer.start_link(__MODULE__, @initial_data, name: via_tuple(name))
  end





  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end



  def get_siblings(_id) do
    Enum.random(5..10)
  end


  def long_db_call() do
    Process.sleep(3_000)
    {:ok, %{ :data => "received"}}
  end

  # @impl true
  # def handle_cast(:begin, state) do
  #   [ :one, :two, :three ]
  #   |> Enum.map(&query_async/1)

  #   {:noreply, state}
  # end

  @impl true
  def handle_cast(:begin, state) do
    result = get_siblings(Keyword.get(state, :id))

    new_state = Keyword.put(state, :siblings, result)
    {:noreply, new_state, {:continue, :moar_data}}
  end



  def continue(:moar_data, state) do
    {:ok, db_res} = long_db_call()
    v = Map.get(db_res, :data)

    new_state = Keyword.put(state, :new_data, v)
    {:noreply, new_state, {:continue, :double_data}}
  end

  def continue(:double_data, state) do

    {:ok, db_res} = long_db_call()

    v = Map.get(db_res, :data)

    new_state = Keyword.put(state, :double_data, v)

    {:noreply, new_state}
  end


  def query_async(_arg) do
    Enum.random(2..5)
    |> Process.sleep()
  end

  defp via_tuple(name) do
    {:via, Registry, {@registry, name}}
  end

end
