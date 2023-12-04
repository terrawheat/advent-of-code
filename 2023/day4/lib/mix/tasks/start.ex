defmodule Mix.Tasks.Start do
  @moduledoc """
  Runs the code
  """

  use Mix.Task

  @shortdoc "Executes the Day4.run/1 function"
  def run([part]) do
    Day4.run(part)
  end
end
