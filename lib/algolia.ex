defmodule Algolia do
 use Application

 @registry :process_registry

  def start(_type, _args) do
    children = [
      {Registry, [keys: :unique, name: @registry]},
      DynoSupervisor,
      FrequencySupervisor
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)

  end

end
