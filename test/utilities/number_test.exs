defmodule Utils.NumberTest do
  use ExUnit.Case

  alias Utils.Number

  describe "parse_int/1" do
    test "handles a string value" do
      assert Number.parse_int("5") == 5
    end

    test "handles an integer valuer" do
      assert Number.parse_int(5) == 5
    end
  end
end
