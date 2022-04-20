defmodule DynoSupervisor do
  use DynamicSupervisor
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


    # def find_or_create_process(account_id) when is_integer(account_id) do

    #   if account_process_exists?(account_id) do
    #     {:ok, account_id}
    #   else
    #     account_id |> create_account_process
    #   end
    # end

    # def account_process_exists?(account_id) when is_integer(account_id) do
    #   case Registry.lookup(@registry, account_id) do
    #     [] -> false
    #     _ -> true
    #   end
    # end


    # Creates a new account process, based on the `account_id` integer.

    # Returns a tuple such as `{:ok, account_id}` if successful.
    # If there is an issue, an `{:error, reason}` tuple is returned.

    # def create_account_process(account_id) when is_integer(account_id) do
    #   case Supervisor.start_child(__MODULE__, [account_id]) do
    #     {:ok, _pid} -> {:ok, account_id}
    #     {:error, {:already_started, _pid}} -> {:error, :process_already_exists}
    #     other -> {:error, other}
    #   end
    # end

    # def account_process_count, do: Supervisor.which_children(__MODULE__) |> length

    # def account_ids do
    #   Supervisor.which_children(__MODULE__)
    #   |> Enum.map(fn {_, pid, _, _} ->
    #     Registry.keys(@registry, pid)
    #     |> List.first
    #   end)
    #   |> Enum.sort
    # end


end
