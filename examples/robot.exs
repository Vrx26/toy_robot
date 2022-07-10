alias ToyRobot.{CommandRunner, CommandInterpreter}

File.stream!("examples/commands.txt")
|> Enum.map(&String.trim/1)
|> CommandInterpreter.interpret()
|> CommandRunner.run()
