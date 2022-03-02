defmodule Splitters do
  @moduledoc """

    Splitting functions

  """



  @doc """

    Splits list on matching id

      iex>  Splitters.split_list_by_id(2, [1,2,3])
      {[2], [1,3]}

  """
  @spec split_list_by_id(any, list()) :: {list, list}
  def split_list_by_id(id, arr) do
    arr
    |> Enum.split_with(&(&1 == id))
  end

  @doc """

    Splits list on key arg is tuple {key, value}

      iex>  arr = [%{:key => 2}, %{:key => 6}, %{:key => 8}]
      ...>  Splitters.split_list_by_key({:key, 6}, arr)
      {[%{:key => 6}], [%{:key => 2}, %{:key => 8}]}

  """
  @spec split_list_by_key({atom, any()}, list()) :: {list, list}
  def split_list_by_key({key, value}, arr) do
    arr
    |> Enum.split_with(&(Map.get(&1, key) == value))
  end

end
