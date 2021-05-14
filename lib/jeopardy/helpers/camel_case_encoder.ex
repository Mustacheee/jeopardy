defmodule Jeopardy.CamelCaseEncoder do
  defmacro __using__(opts) do
    quote do
      defimpl Jason.Encoder, for: unquote(opts[:for]) do
        def encode(list, unquote(opts[:encode_opts])) do
          IO.inspect(unquote(opts[:encode_opts]))
          x =
            list
            |> Map.take([:id, :name, :game_id])
            |> Enum.map(fn {key, value} ->
              {Inflex.camelize(to_string(key), :lower), value}
            end)
            |> Enum.into(%{})

          IO.inspect(x)
          IO.inspect(Map.take(list, [:id, :name, :game_id]))
          Jason.Encode.map(Map.take(list, [:id, :name, :game_id]), unquote(opts[:encode_opts]))
        end
      end
    end
  end
end
