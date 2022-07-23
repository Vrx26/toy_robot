defmodule ToyRobot.CommandInterpreterTest do
  use ExUnit.Case
  doctest ToyRobot.CommandInterpreter
  alias ToyRobot.CommandInterpreter

  test "handles all commands" do
    commands = ["PLACE 1,2,EAST", "MOVE", "LEFT", "RIGHT", "REPORT"]

    assert [
             {:place, %{north: 2, east: 1, facing: :east}},
             :move,
             :turn_left,
             :turn_right,
             :report
           ] = commands |> CommandInterpreter.interpret()
  end

  test "marks commands as invalid" do
    commands = ["SPIN", "TWIRL", "EXTERMINATE", "PLACE 1, 2, NORTH", "move", "tUrN_LEFT"]

    output = commands |> CommandInterpreter.interpret()

    assert output == [
             {:invalid, "SPIN"},
             {:invalid, "TWIRL"},
             {:invalid, "EXTERMINATE"},
             {:invalid, "PLACE 1, 2, NORTH"},
             {:invalid, "move"},
             {:invalid, "tUrN_LEFT"}
           ]
  end
end
