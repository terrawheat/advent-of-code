defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def get_data do
    File.read!("./source.txt")
  end

  def parse_data(data) do
    data
    |> String.split(~r/\R/)
    |> Enum.map(fn line ->
      [prefix, numbers] = String.split(line, ":", trim: true)
      [winners, picks] = String.split(numbers, "|", trim: true)
      [id, _] = Regex.run(~r/(\d+)/, prefix)

      %{
        id: id,
        winners: MapSet.new(String.split(winners, ~r/\s+/, trim: true) |> Enum.filter(&(&1))),
        picks: MapSet.new(String.split(picks, ~r/\s+/, trim: true) |> Enum.filter(&(&1))),
      }

    end)
  end

  def run("1") do
    get_data()
    |> parse_data()
    |> Enum.map(&(MapSet.intersection(&1.winners, &1.picks)))
    |> Enum.filter(&(MapSet.size(&1) != 0))
    |> Enum.map(&(Integer.pow(2, MapSet.size(&1) - 1)))
    |> Enum.sum()
    |> IO.inspect()
  end

  def run("2") do
    card_stats = get_data()
    |> parse_data()
    |> Enum.map(&([Integer.parse(&1.id), MapSet.size(MapSet.intersection(&1.winners, &1.picks))]))
    |> Enum.reduce(Enum.to_list(1..198), fn [{id, _}, wins], cards ->
      freq = Enum.count(cards, &(&1 == id))

      max_card = min(198, id + wins)

      IO.puts "Current Card: #{id} -- # of cards: #{freq} -- # of wins: #{wins}"
      new_cards = for next_card <- (id + 1)..max_card, wins != 0 do
        for i <- 1..(freq) do
          next_card
        end
      end

      List.flatten([new_cards | cards])
    end)

    IO.inspect(length(card_stats))
  end
end
