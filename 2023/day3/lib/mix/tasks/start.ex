defmodule Mix.Tasks.Start do
  @moduledoc """
  Runs the code
  """

  use Mix.Task

  @shortdoc "Executes the Day3.run/1 function"
  def run([part]) do
    Day3.run(part)
  end
end
