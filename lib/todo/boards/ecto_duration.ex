defmodule Todo.Boards.EctoDuration do
  use Ecto.Type
  use Timex

  def type, do: :integer

  def cast(term) when is_binary(term) do
    {value, unit} =
      term
      |> String.split("-")
      |> List.to_tuple()

    {:ok,
     case String.to_atom(unit) do
       :hour -> Duration.from_hours(String.to_integer(value))
       :day -> Duration.from_days(String.to_integer(value))
     end}
  end

  def cast(_), do: :error

  def load(data) when is_integer(data) do
    {:ok, Duration.from_minutes(data)}
  end

  def dump(duration), do: {:ok, Duration.to_minutes(duration, truncate: true)}

  def dump(_), do: :error
end
