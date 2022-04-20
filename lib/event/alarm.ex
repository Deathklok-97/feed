defmodule Alarm do
  use GenServer

  @moduledoc """
    Issue error log to splunk or external source as an event was risen or 
  """

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end


  def init(_arg) do
    {:ok, []}
  end


end
