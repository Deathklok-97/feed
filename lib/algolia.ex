defmodule Algolia do
 use Application

  def start(_type, _args) do
    children = [
      {Registry, [name: Registry.DynamicSession, keys: :unique]},
      {DynamicSupervisor, [name: Boundary.DynamicSession, strategy: :one_for_one]},
      FrequencySupervisor,
      EventSupervisor
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)

  end

end
