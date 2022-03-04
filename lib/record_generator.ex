defmodule RecordGenerator do


  @spec get_random_number_of_siblings :: integer
  defp get_random_number_of_siblings, do: Enum.random(1..3)

  @spec get_random_ids(integer) :: [integer]
  defp get_random_ids(number), do: for _n <- 1..number, do: Enum.random(11111..99999)

  @doc """
    Simulate collection of products

    Similar to the idea of a product family.
    The collection would theoretically have some association between ids
  """
  @spec get_collection_of_ids :: [integer]
  def get_collection_of_ids do
    get_random_number_of_siblings()
    |> get_random_ids()
  end

end
