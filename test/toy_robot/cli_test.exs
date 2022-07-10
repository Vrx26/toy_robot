defmodule ToyRobot.CliTest do
  use ExUnit.Case
  doctest ToyRobot.CLI
  import ExUnit.CaptureIO

  test "call function without arguments" do
    output = capture_io(fn -> ToyRobot.CLI.main([]) end)

    assert output |> String.trim() == "Usage: toy_robot example/commands.txt"
  end

  test "too many arguments" do
    output = capture_io(fn -> ToyRobot.CLI.main(["commands.txt", "cmd.txt"]) end)

    assert output |> String.trim() == "Usage: toy_robot example/commands.txt"
  end

  test "wrong file path" do
    output = capture_io(fn -> ToyRobot.CLI.main(["cmd.txt"]) end)

    assert output |> String.trim() == "The file cmd.txt doesn't exist"
  end

  test "correct input" do
    path = Path.expand("test/fixtures/commands.txt")

    output = capture_io(fn -> ToyRobot.CLI.main([path]) end)

    assert output |> String.trim() == "The robot is at (1, 4) and is facing EAST"
  end
end
