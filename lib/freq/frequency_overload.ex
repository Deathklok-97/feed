defmodule FrequencyOverload do
  use GenServer

  @moduledoc """
    Overloader keeps ids in loop data, uniques the messages coming through periodically
  """


  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    {:ok, []}
  end

end
