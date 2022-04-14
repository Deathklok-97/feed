defmodule FrequencySupervisor do
  use Supervisor

  def init(_args) do
    children = [
      {FrequencyWorker, [] },
      {FrequencyOverload, []}
    ]

    opts = [ strategy: :one_for_one name: __MODULE__]

    Supervisor.start_link(children, opts)
  end

end
