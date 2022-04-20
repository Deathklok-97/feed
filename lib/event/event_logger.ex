defmodule EventLogger do

  use GenServer

  @default_handlers [ {:splunk, :enabled} ]

  def start_link(opts) do
    handlers = Keyword.merge(@default_handlers, opts)
    
    GenServer.start_link(__MODULE__, handlers, name: __MODULE__)
  end

  @impl true
  def init(handlers) do
    {:ok, handlers}
  end





end
