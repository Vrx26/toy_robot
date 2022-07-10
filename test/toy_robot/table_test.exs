defmodule ToyRobot.TableTest do
  use ExUnit.Case
  doctest ToyRobot.Table
  alias ToyRobot.Table

  describe "basic tests for table" do
    setup do
      %{table: %Table{north_boundary: 4, east_boundary: 4}}
    end

    test "postition 4, 4", %{table: table} do
      assert Table.valid_position?(table, %{north: 4, east: 0}) == true
    end
  end
end
