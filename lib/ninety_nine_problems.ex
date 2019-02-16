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
  def p102_last_but([e | [_]]), do: e
  def p102_last_but([_ | rest]), do: p102_last_but(rest)

  @doc """
  Find the K'th element of a list.
  """
  def p103_element_at([e | _], 0), do: e
  def p103_element_at([_ | rest], k), do: p103_element_at(rest, k - 1)

  @doc """
  Find the number of elements of a list.
  """
  def p104_length(l), do: p104_length_n(l, 0)
  defp p104_length_n([], n), do: n
  defp p104_length_n([_ | rest], n), do: p104_length_n(rest, n + 1)

  @doc """
  Reverse a list.
  """
  def p105_reverse([]), do: []
  def p105_reverse([e | rest]), do: p105_reverse(rest) ++ [e]

  @doc """
  Find out whether a list is a palindrome.

  A palindrome can be read forward or backward; e.g. [x,a,m,a,x].
  """
  def p106_palindrom?(l), do: l == p105_reverse(l)

  @doc """
  Flatten a nested list structure.

  Transform a list, possibly holding lists as elements into a 'flat'
  list by replacing each list with its elements (recursively).

  Example:
  ?- my_flatten([a, [b, [c, d], e]], X).
  X = [a, b, c, d, e]

  Hint: Use the predefined predicates is_list/1 and append/3
  """
  def p107_flatten([]), do: []
  def p107_flatten([e | rest]) when is_list(e), do: p107_flatten(e) ++ p107_flatten(rest)
  def p107_flatten([e | rest]), do: [e] ++ p107_flatten(rest)

  @doc """
  Eliminate consecutive duplicates of list elements.

  If a list contains repeated elements they should be replaced with
  a single copy of the element. The order of the elements should not
  be changed.

  Example:
  ?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [a,b,c,a,d,e]
  """
  def p108_compress([]), do: []
  def p108_compress([e]), do: [e]
  def p108_compress([e | [ee | rest]]) when e == ee, do: p108_compress([ee | rest])
  def p108_compress([e | [ee | rest]]), do: [e] ++ p108_compress([ee | rest])
end
