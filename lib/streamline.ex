defmodule Streamline do
  defmacro as(incoming, match) do
    quote do
      unquote(match) = unquote(incoming)
    end
  end

  defmacro then_if(value, predicate, do: true_func) do
    quote do
      v = unquote(value)
      predicate_result = unquote(predicate).(v)

      if predicate_result do
        unquote(true_func).(v)
      else
        v
      end
    end
  end

  defmacro then_if(value, predicate, do: true_func, else: false_func) do
    quote do
      v = unquote(value)
      predicate_result = unquote(predicate).(v)

      if predicate_result do
        unquote(true_func).(v)
      else
        unquote(false_func).(v)
      end
    end
  end

  @doc """
  Matches the first argument, `incoming`, against `match` and returns `return`.

  Slightly cleaner to read than `Kernel.then/2` and no anonymous function is created or called.

  ## Examples

        File.read(filename)
        |> map({:ok, content} ~> content)

        File.read(filename)
        |> map({:ok, content} ~> String.length(content))

  """
  defmacro map(incoming, {:~>, _, [match, return]}) do
    quote do
      unquote(match) = unquote(incoming)
      unquote(return)
    end
  end
end
