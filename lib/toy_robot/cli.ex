defmodule ToyRobot.CLI do
  alias ToyRobot.{CommandRunner, CommandInterpreter}

  def main([path]) do
    if File.exists?(path) do
      File.stream!(path)
      |> Enum.map(&String.trim/1)
      |> CommandInterpreter.interpret()
      |> CommandRunner.run()
    else
      IO.puts("The file #{path} doesn't exist")
    end
  end

  def main(_) do
    IO.puts("Usage: toy_robot example/commands.txt")
  end
end
