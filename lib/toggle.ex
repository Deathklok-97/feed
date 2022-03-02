defmodule Toggle do
  use Agent

  @moduledoc """
    Toggles enabled/disabled for feed
  """

  @doc false
  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(initial_value \\ :enabled) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end


  @doc """

    Returns the current toggle value

  """
  @spec toggle_value :: :enabled | :disabled
  def toggle_value do
    Agent.get(__MODULE__, & &1)
  end

  @doc """

    Toggles current toggle value

      {:ok, pid} = Toggle.start_link(:enabled)
      Toggle.toggle_value
      :disabled

  """
  @spec toggle_toggle :: :enabled | :disabled
  def toggle_toggle do
    Agent.get_and_update(__MODULE__, &({&1, uno_reverse(&1)}))
  end

  defp uno_reverse(:enabled), do: :disabled
  defp uno_reverse(:disabled), do: :enabled
  defp uno_reverse(_), do: :disabled

end
