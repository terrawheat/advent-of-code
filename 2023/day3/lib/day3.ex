defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  def get_data do
    File.read!("./source.txt")
    |> String.split(~r/\R/)
    |> Enum.with_index()
  end

  def is_valid_number?(data, %{line: line, char_index: char_index, length: length}, true) do
    symbol_detector = ~r/[^\.\d]/

    {prev_line, _} = Enum.at(data, line - 1)
    {current_line, _} = Enum.at(data, line)

    matches = for i <- char_index..(char_index + (length - 1)) do
      [
        [String.at(prev_line, i - 1), String.at(prev_line, i), String.at(prev_line, i + 1)],
        [String.at(current_line, i - 1), String.at(current_line, i), String.at(current_line, i + 1)],
      ]
      |> List.flatten()
      |> Enum.any?(&(Regex.match?(symbol_detector, &1 || ".")))
    end

    Enum.any?(matches)
  end

  def is_valid_number?(data, %{line: 0, char_index: char_index, length: length}) do
    symbol_detector = ~r/[^\.\d]/
    {current_line, _} = Enum.at(data, 0)
    {next_line, _} = Enum.at(data, 1)

    matches = for i <- char_index..(char_index + (length - 1)) do
      [
        [String.at(current_line, i - 1), String.at(current_line, i), String.at(current_line, i + 1)],
        [String.at(next_line, i - 1), String.at(next_line, i), String.at(next_line, i + 1)]
      ]
      |> List.flatten()
      |> Enum.any?(&(Regex.match?(symbol_detector, &1 || ".")))
    end

    Enum.any?(matches)
  end

  def is_valid_number?(data, %{line: line, char_index: char_index, length: length}) do
    cond do
      (length(data) - 1) == line ->
        is_valid_number?(data, %{line: line, char_index: char_index, length: length}, true)
      true ->
        matches = for i <- char_index..(char_index + (length - 1)) do
          symbol_detector = ~r/[^\.\d]/

          {prev_line, _} = Enum.at(data, line - 1)
          {current_line, _} = Enum.at(data, line)
          {next_line, _} = Enum.at(data, line + 1)

          [
            [String.at(prev_line, i - 1), String.at(prev_line, i), String.at(prev_line, i + 1)],
            [String.at(current_line, i - 1), String.at(current_line, i), String.at(current_line, i + 1)],
            [String.at(next_line, i - 1), String.at(next_line, i), String.at(next_line, i + 1)]
          ]
          |> List.flatten()
          |> Enum.any?(&(Regex.match?(symbol_detector, &1 || ".")))
        end

        Enum.any?(matches)
    end
  end


  def run("1") do
    parsed = get_data()

    for {line, line_index} <- parsed do
      num_regex = ~r/(\d+)/
      numbers = Regex.scan(num_regex, line) |> Enum.with_index()
      indices = Regex.scan(num_regex, line, return: :index)

      matches = for {[number, _], index} <- numbers do
        [{char_index, length}, _] = Enum.at(indices, index)
        %{number: number, line: line_index, char_index: char_index, length: length}
      end

      matches
      |> Enum.filter(fn m -> is_valid_number?(parsed, m) end)
      |> Enum.map(&(String.to_integer(&1.number, 10)))
    end
    |> List.flatten()
    |> Enum.sum()
    |> IO.inspect()
  end
end
