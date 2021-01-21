defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a string representation of a clock:

  iex> Clock.new(8, 9) |> to_string
  "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(h, m) when h > 23, do: new(h - 24, m)
  def new(h, m) when h < 0, do: new(h + 24, m)
  def new(h, m) when m > 59, do: new(h + 1, m - 60)
  def new(h, m) when m < 0, do: new(h - 1, m + 60)
  def new(h, m), do: %Clock{hour: h, minute: m}

  @doc """
  Adds two clock times:

  iex> Clock.add(10, 0) |> Clock.add(3) |> to_string
  "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: h, minute: m}, add_minute),
    do: new(h, m + add_minute)
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}) do
    hours_ = String.pad_leading(Integer.to_string(hour), 2, "0")
    minutes_ = String.pad_leading(Integer.to_string(minute), 2, "0")

    hours_ <> ":" <> minutes_
  end
end
