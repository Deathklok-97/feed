defmodule ToggleTests do
  use ExUnit.Case, async: true
  use PropCheck

  alias Toggle

  property "starts disabled" do
    forall x <- not_enabled(any())  do
      Toggle.start_link(x)
      Toggle.toggle_value === :disabled
    end
  end

  def not_enabled(gen) do
    such_that g <- gen, when: g != :enabled
  end

end
