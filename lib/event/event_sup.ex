defmodule EventSupervisor do
  use Supervisor

  @moduledoc """
    The idea is going to be adding dynamic handlers during run time as they're registered with this Event Supervisor
    General handlers being things like file output/ standardIO/ splunk
  """

  def start_link(_arg) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      Alarm,
      EventLogger
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
