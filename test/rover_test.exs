defmodule RoverTest do
  use ExUnit.Case

  describe "new/1" do
    test "returns a rover" do
      x = 1
      y = 1
      o = "W"
      ins = []

      assert %Rover{
               x: ^x,
               y: ^y,
               orientation: ^o,
               instructions: ^ins
             } = Rover.new(%{x: x, y: y, orientation: o, instructions: ins})
    end

    test "handles stringified coordinates" do
      x = 1
      y = 1
      o = "W"
      ins = []

      assert %Rover{
               x: ^x,
               y: ^y,
               orientation: ^o,
               instructions: ^ins
             } = Rover.new(%{x: "1", y: "1", orientation: o, instructions: ins})
    end
  end

  describe "execute/1" do
    setup do
      rover =
        Rover.new(%{
          x: 1,
          y: 2,
          orientation: "N",
          instructions: []
        })

      %{rover: rover}
    end

    test "turns left", %{rover: rover} do
      result = Rover.execute(%{rover | instructions: ["L"]})

      assert result.x == rover.x
      assert result.y == rover.y
      refute result.orientation == rover.orientation
      assert result.orientation == "W"
      assert result.instructions == []
    end

    test "turns right", %{rover: rover} do
      result = Rover.execute(%{rover | instructions: ["R"]})

      assert result.x == rover.x
      assert result.y == rover.y
      refute result.orientation == rover.orientation
      assert result.orientation == "E"
      assert result.instructions == []
    end

    test "moves forward", %{rover: rover} do
      result = Rover.execute(%{rover | instructions: ["M"]})

      assert result.x == rover.x
      assert result.y == rover.y + 1
      assert result.orientation == "N"
      assert result.instructions == []
    end

    test "runs multiple instructions - case 1.1", %{rover: rover} do
      assert %Rover{
               x: 1,
               y: 3,
               orientation: "N",
               instructions: []
             } = Rover.execute(%{rover | instructions: ~w(L M L M L M L M M)})
    end

    test "runs multiple instructions - case 1.2" do
      rover =
        Rover.new(%{
          x: 3,
          y: 3,
          orientation: "E",
          instructions: ~w(M M R M M R M R R M)
        })

      assert %Rover{
               x: 5,
               y: 1,
               orientation: "E",
               instructions: []
             } = Rover.execute(rover)
    end

    test "runs multiple instructions - case 2.1" do
      rover =
        Rover.new(%{
          x: 0,
          y: 0,
          orientation: "S",
          instructions: ~w(L M M L M)
        })

      assert %Rover{
               x: 2,
               y: 1,
               orientation: "N",
               instructions: []
             } = Rover.execute(rover)
    end

    test "runs multiple instructions - case 2.2" do
      rover =
        Rover.new(%{
          x: 1,
          y: 2,
          orientation: "W",
          instructions: ~w(L M L M R M)
        })

      # README specifies 1 0 S but I think it's wrong
      assert %Rover{
               x: 2,
               y: 0,
               orientation: "S",
               instructions: []
             } = Rover.execute(rover)
    end
  end
end
