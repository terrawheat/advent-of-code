defmodule Day2 do
  @moduledoc """
  This module defines the code for Day 2 of Advent of Code 2023
  """

  alias Day2.GameData

  @max_reds 12
  @max_greens 13
  @max_blues 14

  def get_data do
    File.read!("./source.txt")
    |> String.split(~r/\R/)
  end

  defp get_colour_max_for_line(line, colour) do
    Regex.scan(~r/(\d+) #{colour}/, line)
        |> Enum.map(fn [_, colour] ->
          {res, _} = Integer.parse(colour, 10)

          res
        end)
        |> Enum.max()
  end

  def parse_lines(data) do
    Enum.map(data, fn line ->
      [_, game_id_match] = Regex.run(~r/^Game (\d+)/, line)
      {game_id, _} = Integer.parse(game_id_match, 10)

      green = get_colour_max_for_line(line, "green")
      red = get_colour_max_for_line(line, "red")
      blue = get_colour_max_for_line(line, "blue")

      %GameData{id: game_id, green: green, red: red, blue: blue}
    end)
  end

  def is_valid_game?(data) do
    data.red <= @max_reds && data.green <= @max_greens && data.blue <= @max_blues
  end

  def calc_power(data) do
    data.red * data.blue * data.green
  end

  def run("1") do
    get_data()
    |> parse_lines()
    |> Enum.filter(&is_valid_game?/1)
    |> Enum.map(&(&1.id))
    |> Enum.sum()
  end

  def run("2") do
    get_data()
    |> parse_lines()
    |> Enum.map(&calc_power/1)
    |> Enum.sum()
  end
end
