defmodule Day2Test do
  use ExUnit.Case, async: false

  import Mock
  alias Day2.GameData

  @sample_input "Game 1: 10 green, 9 blue, 1 red; 1 red, 7 green; 11 green, 6 blue; 8 blue, 12 green\nGame 2: 11 red, 7 green, 3 blue; 1 blue, 8 green, 5 red; 2 red, 12 green, 1 blue; 10 green, 5 blue, 7 red"
  @sample_listed [
    "Game 1: 10 green, 9 blue, 1 red; 1 red, 7 green; 11 green, 6 blue; 8 blue, 12 green",
    "Game 2: 11 red, 7 green, 3 blue; 1 blue, 8 green, 5 red; 2 red, 12 green, 1 blue; 10 green, 5 blue, 7 red",
  ]
  @sample_parsed [
    %GameData{green: 12, red: 1, blue: 9, id: 1},
    %GameData{green: 12, red: 11, blue: 5, id: 2},
  ]


  describe "get_data" do
    test "returns data" do
      with_mock File, [read!: fn (_path) -> @sample_input end] do
        assert Day2.get_data() == @sample_listed
      end
    end
  end

  describe "parse_lines" do
    test "returns data" do
      assert Day2.parse_lines(@sample_listed) == @sample_parsed
    end
  end

  describe "is_valid_game?" do
    for [desc, data, result] <- [
      ["too many reds", Macro.escape(%GameData{red: 15}), false],
      ["too many blues", Macro.escape(%GameData{blue: 15}), false],
      ["too many greens", Macro.escape(%GameData{green: 15}), false],
      ["valid", Macro.escape(%GameData{red: 5, green: 2, blue: 6}), true],
    ] do
      test "#{desc} -> #{result}" do
        assert Day2.is_valid_game?(unquote(data)) == unquote(result)
      end
    end
    test "matches within limits" do
    end
  end

  describe "calc_power" do
    assert Day2.calc_power(Enum.at(@sample_parsed, 0)) == 108
    assert Day2.calc_power(Enum.at(@sample_parsed, 1)) == 660
  end
end
