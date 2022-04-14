defmodule FrequencyTracker do
  use GenServer
  require Logger

  @registry :process_registry


  #Client
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end


  def log_state(process_name) do
    process_name
    |> via_tuple()
    |> GenServer.call(:log_state)
  end


  #Server

  @impl true
  def init(name) do
    Logger.info("starting process #{name}")
    {:ok, []}
  end

  @impl true
  def handle_call(:log_state, _from, state) do
    {:reply, "State: #{inspect(state)}", state}
  end


  defp via_tuple(id) do
    {:via, Registry, {@registry, id} }
  end
end
