defmodule DynamicWorker do
  use GenServer

  @registry :process_registry

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end


  def child_specification(process_name) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [process_name]},
      restart: :transient
    }
  end


  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  defp via_tuple(name) do
    {:via, Registry, {@registry, name}}
  end

end
