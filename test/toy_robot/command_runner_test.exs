defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case
  doctest ToyRobot.CommandInterpreter
  alias ToyRobot.{Simulation, CommandRunner}
  import ExUnit.CaptureIO

  test "valid robot placement" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 2, east: 1, facing: :north}}])

    assert robot.north == 2
    assert robot.east == 1
    assert robot.facing == :north
  end

  test "invalid robot placement" do
    simulation = CommandRunner.run([{:place, %{north: 9, east: 9, facing: :north}}])

    assert simulation == nil
  end

  test "ignoring commands before :place" do
    %Simulation{robot: robot} =
      CommandRunner.run([:move, :turn_left, {:place, %{north: 2, east: 3, facing: :east}}])

    assert robot.north == 2
    assert robot.east == 3
    assert robot.facing == :east
  end

  test "handle place + move commands" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 2, east: 3, facing: :east}}, :move])

    assert robot.north == 2
    assert robot.east == 4
    assert robot.facing == :east
  end

  test "handle place + invalid move commands" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 2, facing: :north}}, :move])

    assert robot.north == 4
    assert robot.east == 2
    assert robot.facing == :north
  end

  test "handle place + turn right commands" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 2, facing: :north}}, :turn_right])

    assert robot.north == 4
    assert robot.east == 2
    assert robot.facing == :east
  end

  test "handle place + turn left commands" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 2, facing: :north}}, :turn_left])

    assert robot.north == 4
    assert robot.east == 2
    assert robot.facing == :west
  end

  test "handle place + report commands" do
    commands = [{:place, %{north: 4, east: 2, facing: :north}}, :report]

    output = capture_io(fn -> CommandRunner.run(commands) end)

    assert String.trim(output) == "The robot is at (2, 4) and is facing NORTH"
  end

  test "handle invalid command" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 2, facing: :north}}, {:invalid, "JUMP"}])

    assert robot.north == 4
    assert robot.east == 2
    assert robot.facing == :north
  end

  test "prevents move north" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 2, facing: :north}}, :move])

    assert robot.north == 4
  end

  test "prevents move south" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 0, east: 2, facing: :south}}, :move])

    assert robot.north == 0
  end

  test "prevents move east" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 4, facing: :east}}, :move])

    assert robot.east == 4
  end

  test "prevents move west" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{north: 4, east: 0, facing: :west}}, :move])

    assert robot.east == 0
  end
end
