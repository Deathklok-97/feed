defmodule GeneratorTests do
    use ExUnit.Case, async: true
    use PropCheck


    #Just stacking these up here, adding examples ongoing
    def even(), do: let n <- integer(), do: n * 2
    def odd(), do: let n <- integer(), do: n*2+1

    def text_like() do
      let l <-
          list(
            frequency([
              {80, range(?a, ?z)},
              {10, ?\s},
              {1, ?\n},
              {1, oneof([?., ?-, ?!, ??, ?,])},
              {1, range(?0, ?9)}
            ])
          ) do
        to_string(l)
      end
    end

    def robot_path do
      list(oneof([:left, :right, :up, :down]))
    end

end
