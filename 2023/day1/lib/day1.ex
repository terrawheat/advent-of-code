defmodule Day1 do
  @moduledoc """
  This module defines the code for Day 1 of Advent of Code 2023
  """

  def get_data() do
    {:ok, contents} = File.read("./source.txt")

    contents
    |> String.split(~r/\R/)
  end

  def detect_singular([a, nil]) do
    [a, a]
  end

  def detect_singular([nil, b]) do
    [b, b]
  end

  def detect_singular([a, b]) do
    [a, b]
  end

  def select_pair(input_string) do
    matches =
      Regex.scan(~r/(?=(one|two|three|four|five|six|seven|eight|nine|\d{1}))/, input_string)
      |> Enum.map(fn [_, m] -> m end)

    [matches |> Enum.at(0), matches |> Enum.at(-1)] |> detect_singular
  end

  def select_pairs(input_list) do
    input_list
    |> Enum.map(&Day1.select_pair/1)
  end

  def translate_pairs(input_list) do
    input_list
    |> Enum.map(fn [a, b] -> [translate(a), translate(b)] end)
  end

  def to_number(str) do
    {num, _} = Integer.parse(str, 10)

    num
  end

  def translate("one") do
    "1"
  end

  def translate("two") do
    "2"
  end

  def translate("three") do
    "3"
  end

  def translate("four") do
    "4"
  end

  def translate("five") do
    "5"
  end

  def translate("six") do
    "6"
  end

  def translate("seven") do
    "7"
  end

  def translate("eight") do
    "8"
  end

  def translate("nine") do
    "9"
  end

  def translate(digit) do
    digit
  end

  def run do
    Day1.get_data()
    |> Day1.select_pairs()
    |> Day1.translate_pairs()
    |> Enum.map(fn pair -> Enum.join(pair, "") end)
    |> Enum.map(&Day1.to_number/1)
    |> Enum.sum()
  end
end
