defmodule ExdocTest do
  use ExUnit.Case, async: true
  doctest Toggle
  doctest Splitters
end
