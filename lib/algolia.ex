defmodule Algolia do
 use Application

 alias FrequencySupervisor

 @registry :process_registry

  def start(_arg, _arg2) do
    children = [
      {Registry, [keys: :unique, name: @registry]},
      {FrequencySupervisor, []},
      {EventSupervisor, []},

    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)

  end

end
