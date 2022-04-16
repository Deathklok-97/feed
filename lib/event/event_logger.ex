defmodule EventLogger do

  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    {:ok, []}
  end


  


end
