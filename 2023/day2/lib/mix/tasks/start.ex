defmodule Mix.Tasks.Start do
  @moduledoc """
  Runs the code
  """

  use Mix.Task

  @shortdoc "Executes the Day2.run/1 function"
  def run([part]) do
    Day2.run(part)
  end
end
