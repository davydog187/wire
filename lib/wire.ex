defmodule Wire do
  @moduledoc """
  Documentation for Wire.
  """

  alias Blinkchain.Color

  @colors [
    Color.parse("#9400D3"),
    Color.parse("#4B0082"),
    Color.parse("#0000FF"),
    Color.parse("#00FF00"),
    Color.parse("#FFFF00"),
    Color.parse("#FF7F00"),
    Color.parse("#FF0000")
  ]

  @doc """
  Get a list of nice-looking rainbow colors.
  """
  def colors, do: @colors
end
