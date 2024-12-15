# Streamline

A tiny library of Elixir macros that help keep you in the flow of your pipelines.

## Features

### `as/2` - Capture values in a pipeline

Remain in the flow of the pipeline, while assigning values to variables.

```elixir
# Capture the result of a pipeline
"hello world"
|> String.upcase()
|> String.split()
|> as(words)

IO.inspect(words)    # ["HELLO", "WORLD"]

# Multiple captures
"hello"
|> String.codepoints()
|> Enum.frequencies()
|> as(freqs)
|> Enum.count()
|> as(unique_count)

IO.inspect(freqs)    # %{"h" => 1, "e" => 1, "l" => 2, "o" => 1}
IO.inspect(unique_count)  # 4
```

### `map/2` - Pattern match and transform in a pipeline

Transform values in a pipeline using pattern matching.
Slightly cleaner to read than `Kernel.then/2` and no anonymous function is created or called.
Allows variable to be captured in the pipeline, similar to `as/2`.

```elixir
# Transform & capture values in a pipeline
"some input"
|> Some.request()
|> map({:ok, result} ~> result) # Transform & capture
|> String.codepoints()
|> Enum.frequencies()
|> IO.inspect()

IO.inspect(result) # Prints the value of result captured in the pipeline
```

### `then_if/3` and `then_if/4` - Conditional pipeline branching

```elixir
"hello"
|> String.codepoints()
|> Enum.frequencies()
|> then_if(&(&1["l"] > 1), do: fn _ -> "has multiple L's" end)
# Returns "has multiple L's"

# With else clause
value
|> then_if(&is_number/1,
    do: fn x -> x * 2 end,
    else: fn _ -> 0 end)
```

### Standard Tuple Helpers

```elixir
ok(value)     # Returns {:ok, value}
error(value)  # Returns {:error, value}
reply(value)  # Returns {:reply, value}
noreply(value) # Returns {:noreply, value}
```
