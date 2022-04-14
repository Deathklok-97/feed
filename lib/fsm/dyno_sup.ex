defmodule DynoSupervisor do

  use DynamicSupervisor
  alias DynamicWorker


  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, [] , name: __MODULE__)
  end

  def start_children(name) do

    child_specification = {DynamicWorker, name}

    DynamicSupervisor.start_child(__MODULE__, child_specification)
  end

  @impl true
  def init(_args) do

    DynamicSupervisor.init(strategy: :one_for_one)
  end

end
