defmodule StreamlineTest do
  use ExUnit.Case
  doctest Streamline

  test "'as' at the end of a pipeline" do
    import Streamline

    "hello"
    |> String.length()
    |> as(len)

    assert len == 5
  end

  test "intermediate 'as' assignments" do
    import Streamline

    "hello"
    |> String.codepoints()
    |> Enum.frequencies()
    |> as(frequencies)
    |> Enum.count()
    |> as(num_uniqs)

    assert Enum.count(frequencies) == num_uniqs
  end

  test "then_if" do
    import Streamline

    result =
      "hello"
      |> String.codepoints()
      |> Enum.frequencies()
      |> then_if(&(&1["l"] > 1), do: fn _ -> :many_l end)
      |> then_if(&(&1 == :many_l), do: fn _ -> "L" end, else: fn _ -> "?" end)

    assert result == "L"
  end
end
