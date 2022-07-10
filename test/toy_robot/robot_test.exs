defmodule ToyRobot.RobotTest do
  use ExUnit.Case
  doctest ToyRobot.Robot
  alias ToyRobot.Robot

  describe "robot facing north" do
    setup do
      %{robot: %Robot{east: 0, north: 0, facing: :north}}
    end

    test "it moves one space north", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
    end

    test "it turns left", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :west
    end

    test "it turns right", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :east
    end
  end

  describe "robot facing east" do
    setup do
      %{robot: %Robot{east: 0, north: 0, facing: :east}}
    end

    test "it moves one space east", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.east == 1
    end

    test "it turns left", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :north
    end

    test "it turns right", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :south
    end
  end

  describe "robot facing south" do
    setup do
      %{robot: %Robot{east: 0, north: 0, facing: :south}}
    end

    test "it moves one space south", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == -1
    end

    test "it turns left", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :east
    end

    test "it turns right", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :west
    end
  end

  describe "robot facing west" do
    setup do
      %{robot: %Robot{east: 0, north: 0, facing: :west}}
    end

    test "it moves one space west", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.east == -1
    end

    test "it turns left", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :south
    end

    test "it turns right", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :north
    end
  end

  describe "robot facing north and moved one step north and one east" do
    setup do
      %{robot: %Robot{east: 1, north: 1, facing: :north}}
    end

    test "it turns right", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :east
    end

    test "it turns left", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :west
    end
  end

  describe "robot facing east and moved north once" do
    setup do
      %{robot: %Robot{east: 0, north: 1, facing: :east}}
    end

    test "it moves forward", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :east
    end
  end

  describe "robot facing west and moved north once" do
    setup do
      %{robot: %Robot{east: 0, north: 1, facing: :west}}
    end

    test "it moves forward", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == -1
      assert robot.facing == :west
    end
  end

  describe "robot facing south and moved east once" do
    setup do
      %{robot: %Robot{east: 1, north: 0, facing: :south}}
    end

    test "it moves forward", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == -1
      assert robot.east == 1
      assert robot.facing == :south
    end
  end

  describe "robot facing  and moved east once" do
    setup do
      %{robot: %Robot{east: 1, north: 0, facing: :north}}
    end

    test "it moves forward", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :north
    end
  end
end
