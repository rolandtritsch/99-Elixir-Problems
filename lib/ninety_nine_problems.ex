defmodule NinetyNineProblems do
  @moduledoc """
  An implementation of the famous 99 Prolog Problems in Elixir.
  """

  @doc """
  Find the last element of a list.
  """
  def p101_last([e | []]), do: e
  def p101_last([_ | rest]), do: p101_last(rest)

  @doc """
  Find the last but one element of a list.
  """
  def p102_lastBut([e | [_]]), do: e
  def p102_lastBut([_ | rest]), do: p102_lastBut(rest)

  @doc """
  Find the K'th element of a list.
  """
  def p103_elementAt([e | _], 0), do: e
  def p103_elementAt([_ | rest], k), do: p103_elementAt(rest, k - 1)

  @doc """
  Find the number of elements of a list.
  """
  def p104_length(l), do: p104_lengthN(l, 0)
  def p104_lengthN([], n), do: n
  def p104_lengthN([_ | rest], n), do: p104_lengthN(rest, n + 1)

  @doc """
  Reverse a list.
  """
  def p105_reverse([]), do: []
  def p105_reverse([e | rest]), do: p105_reverse(rest) ++ [e]
end
