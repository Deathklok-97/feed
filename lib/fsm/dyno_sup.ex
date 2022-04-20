defmodule DynoSupervisor do
  use DynamicSupervisor

  @moduledoc """
    Generates workers through start_child that are finite state machines
    The loop data will not carry query or data source results, only state
  """
  alias DynamicWorker

  @registry :process_registry

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, [] , name: __MODULE__)
  end

  def start_child(name) do
    DynamicSupervisor.start_child(__MODULE__, child_specification(name))
  end


  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def child_specification(process_name) do
    %{
      id: process_name,
      start: {DynamicWorker, :start_link, [process_name]},
      restart: :transient
    }
  end



end
