defmodule Algolia do
 use Application


 @registry :process_registry

  def start() do
    children = [
      {FrequencySupervisor, []},
      {EventSupervisor, []},
      {Register, [keys: :unique, name: @registry]}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)

  end

end
