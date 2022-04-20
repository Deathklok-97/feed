defmodule Alarm do
  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end


  def init(_arg) do
    {:ok, []}
  end

  
end
