defmodule Game.PlayerTest do
  use ExUnit.Case

  alias ToyRobot.Game.Player
  alias ToyRobot.{Robot}

  describe "report" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "report robot position", %{player: player} do
      assert Player.report(player) == %Robot{north: 0, east: 0, facing: :north}
    end
  end

  describe "move" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "move and report robot position", %{player: player} do
      :ok = Player.move(player)
      assert Player.report(player) == %Robot{north: 1, east: 0, facing: :north}
    end
  end
end
