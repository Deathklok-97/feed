defmodule RegistrySuperviosr do
  use Supervisor

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {Registry, [:unique, :product_process_registry]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def find_or_create_process(sale_item_id) when is_integer(sale_item_id) do
    if sale_item_process_exists?(sale_item_id) do
      {:ok, sale_item_id}
    else
      sale_item_id |> create_sale_item_process
    end
  end

  def sale_item_process_exists?(sale_item_id) when is_integer(sale_item_id) do
    case Registry.lookup(:product_process_registry, sale_item_id) do
      [] -> false
      _ -> true
    end
  end

  def child_spec(sale_item_id, opts \\ []) do
    %{
      id: sale_item_id,
      start: {__MODULE__, :start_link, [opts]},
      shutdown: 5_000,
      restart: :transient,
      type: :worker
    }
  end

  def create_sale_item_process(sale_item_id) when is_integer(sale_item_id) do
    case DynamicSupervisor.start_child(__MODULE__, child_spec(sale_item_id)) do
      {:ok, _pid} -> {:ok, sale_item_id}
      {:error, {:already_started, _pid}} -> {:error, :process_already_exists}
      other -> {:error, other}
    end
  end

end
