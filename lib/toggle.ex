defmodule Toggle do
  use Agent

  def start_link(initial_value \\ :enabled) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def toggle_value do
    Agent.get(__MODULE__, & &1)
  end

  def toggle_toggle do
    Agent.update(__MODULE__, &(uno_reverse(&1)))
  end

  defp uno_reverse(:enabled), do: :disabled
  defp uno_reverse(:disabled), do: :enabled

end
