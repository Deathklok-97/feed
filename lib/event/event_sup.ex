defmodule EventSupervisor do
  use Supervisor

  def init(_args) do
    children = [
      {Alarm, []},
      {EventLogger, []}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]

    Supervisor.start_link(children, opts)
  end

end
