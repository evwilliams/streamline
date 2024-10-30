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

  test "map" do
    import Streamline

    simple_return =
      {:ok, "some fancy result"}
      |> map({:ok, val} ~> val)

    assert simple_return == "some fancy result"
  end

  # Code.eval_string otherwise the compiler will smartly warn the match will always fail
  test "map raises on bad match" do
    source =
      """
        import Streamline
        {:error, "some fancy result"}
        |> map({:ok, val} ~> val)
      """

    assert_raise MatchError, fn ->
      Code.eval_string(source)
    end
  end

  test "map with function" do
    import Streamline

    simple_return =
      {:ok, "some fancy result"}
      |> map({:ok, val} ~> String.length(val))

    assert simple_return == 17
  end
end
