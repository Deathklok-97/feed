defmodule AlgoliaTest do
  use ExUnit.Case
  doctest Algolia

  test "greets the world" do
    assert Algolia.hello() == :world
  end
end
