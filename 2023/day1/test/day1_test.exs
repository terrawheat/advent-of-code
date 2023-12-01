

defmodule Day1Test do
  use ExUnit.Case, async: false

  import Mock

  describe "get_data" do
    test "returns data" do
      with_mock File, [read: fn (_path) -> {:ok, "1234\n5678"} end] do
        assert Day1.get_data() == ["1234", "5678"]
      end
    end

    test "raises if error reading" do
      with_mock File, [read: fn (_path) -> :error end] do
        assert_raise MatchError, &Day1.get_data/0
      end
    end
  end

  describe "detect_singular" do
    for [a, b, result] <- [
      [1, 2, [1, 2]],
      [nil, 2, [2, 2]],
      [2, nil, [2, 2]],
    ] do
      test "[#{a}, #{b}] -> [#{Enum.join(result, ", ")}]" do
        assert Day1.detect_singular([unquote(a), unquote(b)]) == unquote(result)
      end
    end
  end

  describe "select_pair" do
    for [input, output] <- [
      ["twoaoaurbg135", ["two", "5"]],
      ["1135four", ["1", "four"]],
      ["2iuybgiou", ["2", "2"]],
      ["aouanveightoune", ["eight", "eight"]],
      ["7eightwo", ["7", "two"]],
    ] do
      test "#{input} -> [#{Enum.join(output, ", ")}]" do
        assert Day1.select_pair(unquote(input)) == unquote(output)
      end
    end
  end
end
