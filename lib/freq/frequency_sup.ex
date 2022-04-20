defmodule FrequencySupervisor do
  use Supervisor


  def start_link(_arg) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      FrequencyTracker,
      FrequencyOverload
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
