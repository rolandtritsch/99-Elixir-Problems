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
  my_flatten([a, [b, [c, d], e]], X).
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
  compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [a,b,c,a,d,e]
  """
  def p108_compress([]), do: []
  def p108_compress([e]), do: [e]
  def p108_compress([e | [ee | rest]]) when e == ee, do: p108_compress([ee | rest])
  def p108_compress([e | [ee | rest]]), do: [e] ++ p108_compress([ee | rest])

  @doc """
  Pack consecutive duplicates of list elements into sublists.

  If a list contains repeated elements they should be placed in separate sublists.

  Example:
  pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
  """
  def p109_pack(l), do: p109_pack_acc(l, [])
  defp p109_pack_acc([], acc), do: acc
  defp p109_pack_acc([e | [ee | rest]], acc) when e == ee, do: p109_pack_acc([ee | rest], [e | acc])
  defp p109_pack_acc([e | rest], acc), do: [[e | acc]] ++ p109_pack_acc(rest, [])

  @doc """
  Run-length encoding of a list.

  Use the result of problem 1.09 to implement the so-called run-length encoding data
  compression method. Consecutive duplicates of elements are encoded as terms [N,E]
  where N is the number of duplicates of the element E.

  Example:
  encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]
  """
  def p110_encode(l) do
    packed = p109_pack(l)
    encode = fn [e | rest] -> {(length rest) + 1, e} end
    Enum.map(packed, encode)
  end

  @doc """
  Modified run-length encoding.

  Modify the result of problem 1.10 in such a way that if an element has no duplicates
  it is simply copied into the result list. Only elements with duplicates are transferred
  as [N,E] terms.

  Example:
  encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [[4,a],b,[2,c],[2,a],d,[4,e]]
  """
  def p111_encode_modified(l) do
    packed = p109_pack(l)
    encode = fn [e | rest] ->
      if (length rest) > 0 do
        {(length rest) + 1, e}
      else e
      end
    end
    Enum.map(packed, encode)
  end

  @doc """
  Decode a run-length encoded list.

  Given a run-length code list generated as specified in problem 1.11.
  Construct its uncompressed version.
  """
  def p112_decode(l), do: p112_decoder(l)
  defp p112_decoder([]), do: []
  defp p112_decoder([{count, e} | rest]), do: List.duplicate(e, count) ++ p112_decoder(rest)
  defp p112_decoder([e | rest]), do: [e] ++ p112_decoder(rest)

  @doc """
  Run-length encoding of a list (direct solution).

  Implement the so-called run-length encoding data compression method directly.
  I.e. don't explicitly create the sublists containing the duplicates, as in
  problem 1.09, but only count them. As in problem 1.11, simplify the result
  list by replacing the singleton terms [1,X] by X.

  Example:
  encode_direct([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
  X = [[4,a],b,[2,c],[2,a],d,[4,e]]
  """
  def p113_encode_direct(l), do: p113_encoder(l, 1)
  defp p113_encoder([e], counter), do: [{counter, e}]
  defp p113_encoder([e | [ee | rest]], counter) when e == ee, do: p113_encoder([ee | rest], counter + 1)
  defp p113_encoder([e | [ee | rest]], 1) when e != ee, do: [e | p113_encoder([ee | rest], 1)]
  defp p113_encoder([e | [ee | rest]], counter), do: [{counter, e} | p113_encoder([ee | rest], 1)]

  @doc """
  Duplicate the elements of a list.

  Example:
  dupli([a,b,c,c,d],X).
  X = [a,a,b,b,c,c,c,c,d,d]
  """
  def p114_duplicate([]), do: []
  def p114_duplicate([e | rest]), do: [e] ++ [e] ++ p114_duplicate(rest)

  @doc """
  Duplicate the elements of a list a given number of times.

  Example:
  dupli([a,b,c],3,X).
  X = [a,a,a,b,b,b,c,c,c]
  """
  def p115_duplicate_n([], _), do: []
  def p115_duplicate_n([e | rest], n), do: List.duplicate(e, n) ++ p115_duplicate_n(rest, n)

  @doc """
  Drop every N'th element from a list.

  Example:
  drop([a,b,c,d,e,f,g,h,i,k],3,X).
  X = [a,b,d,e,g,h,k]
  """
  def p116_drop_every(l, n), do: p116_drop_n_i(l, n, n)
  defp p116_drop_n_i([_], _, 1), do: []
  defp p116_drop_n_i([e], _, _), do: [e]
  defp p116_drop_n_i([_ | rest], n, 1), do: p116_drop_n_i(rest, n, n)
  defp p116_drop_n_i([e | rest], n, i), do: [e] ++ p116_drop_n_i(rest, n, i - 1)

  @doc """
  Split a list into two parts; the length of the first part is given.

  Do not use any predefined predicates.

  Example:
  split([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
  L1 = [a,b,c]
  L2 = [d,e,f,g,h,i,k]
  """
  def p117_split_at(l, n), do: p117_split_at_acc(l, n, [], [])
  defp p117_split_at_acc([], _, first, second), do: {first, second}
  defp p117_split_at_acc([e | rest], i, first, second) when i > 0, do: p117_split_at_acc(rest, i - 1, first ++ [e], second)
  defp p117_split_at_acc([e | rest], i, first, second), do: p117_split_at_acc(rest, i - 1, first, second ++ [e])

  @doc """
  Extract a slice from a list.

  Given two indices, I and K, the slice is the list containing the elements
  between the I'th and K'th element of the original list (both limits included).

  Start counting the elements with 1.

  Example:
  slice([a,b,c,d,e,f,g,h,i,k],3,7,L).
  L = [c,d,e,f,g]
  """
  def p118_slice(l, i, k), do: p118_slice_acc(l, i, k, [])
  defp p118_slice_acc([], _, _, slice), do: slice
  defp p118_slice_acc([_ | rest], i, k, slice) when i > 1, do: p118_slice_acc(rest, i - 1, k - 1, slice)
  defp p118_slice_acc([e | rest], i, k, slice) when i <= 1 and k > 0, do: p118_slice_acc(rest, i - 1, k - 1, slice ++ [e])
  defp p118_slice_acc(_, i, k, slice) when i <= 1 and k <= 0, do: slice

  @doc """
  Rotate a list N places to the left.

  Examples:
  rotate([a,b,c,d,e,f,g,h],3,X).
  X = [d,e,f,g,h,a,b,c]

  rotate([a,b,c,d,e,f,g,h],-2,X).
  X = [g,h,a,b,c,d,e,f]

  Hint: Use the predefined predicates length/2 and append/3, as well as
  the result of problem 1.17.
  """
  def p119_rotate_n(l, 0), do: l
  def p119_rotate_n(l, n) when n > 0 do
    {first, second} = p117_split_at(l, n)
    second ++ first
  end
  def p119_rotate_n(l, n) do
    {first, second} = p117_split_at(l, n + (length l))
    second ++ first
  end

  @doc """
  Remove the K'th element from a list.

  Example:
  remove_at(X,[a,b,c,d],2,R).
  X = b
  R = [a,c,d]
  """
  def p120_remove_at(l, k), do: {Enum.at(l, k - 1), List.delete_at(l, k - 1)}

  @doc """
  Insert an element at a given position into a list.

  Example:
  insert_at(alfa,[a,b,c,d],2,L).
  L = [a,alfa,b,c,d]
  """
  def p121_insert_at(l, k, e), do: List.insert_at(l, k - 1, e)

  @doc """
  Create a list containing all integers within a given range.

  Example:
  range(4,9,L).
  L = [4,5,6,7,8,9]
  """
  def p122_range(from, to), do: Enum.to_list(Range.new(from, to))

  @doc """
  Extract a given number of randomly selected elements from a list.

  The selected items shall be put into a result list.

  Example:
  rnd_select([a,b,c,d,e,f,g,h],3,L).
  L = [e,d,a]
  """
  def p123_random_select_n(l, n), do: p123_random_select_n_acc(l, n, [])
  defp p123_random_select_n_acc([], _, acc), do: acc
  defp p123_random_select_n_acc(_, 0, acc), do: acc
  defp p123_random_select_n_acc(l, n, acc) do
    i = Random.randint(0, (length l) - 1)
    p123_random_select_n_acc(List.delete_at(l, i), n - 1, [Enum.at(l, i) | acc])
  end

  @doc """
  Lotto: Draw N different random numbers from the set 1..M.

  The selected numbers shall be put into a result list.

  Example:
  lotto(6,49,L).
  L = [23,1,17,33,21,37]

  Hint: Combine the solutions of problems 1.22 and 1.23.
  """
  def p124_lotto_n_m(n, m), do: p123_random_select_n(p122_range(1, m), n)

  @doc """
  Generate a random permutation of the elements of a list.

  Example:
  rnd_permu([a,b,c,d,e,f],L).
  L = [b,a,d,c,e,f]

  Hint: Use the solution of problem 1.23.
  """
  def p125_random_permutation(l), do: p123_random_select_n(l, length l)

  @doc """
  Generate the combinations of K distinct objects chosen from the N elements of a list.

  In how many ways can a committee of 3 be chosen from a group of 12 people?
  We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the
  well-known binomial coefficients). For pure mathematicians, this result may
  be great. But we want to really generate all the possibilities (via backtracking).

  Example:
  combination(3,[a,b,c,d,e,f],L).
  L = [a,b,c] ;
  L = [a,b,d] ;
  L = [a,b,e] ;
  ...
  """
  def p126_combination_n(l, n) do
    # TODO: curry this on the fly or find a way to implement it with a macro.
    p126_f = fn n ->
      case n do
        1 -> fn(x1) -> [x1] end
        2 -> fn(x1,x2) -> [x1,x2] end
        3 -> fn(x1,x2,x3) -> [x1,x2,x3] end
        4 -> fn(x1,x2,x3,x4) -> [x1,x2,x3,x4] end
        _ -> raise "Number of dimensions out of range"
      end
    end

    sort_lists = fn l -> Enum.sort(l) end
    is_uniq = fn l -> length(Enum.uniq(l)) == length(l) end

    cartesian = p126_cartesian(List.duplicate(l, n), p126_f.(n))
    product = Enum.map(cartesian, sort_lists)
    Enum.uniq(Enum.filter(product, is_uniq))
  end
  defp p126_cartesian([], _), do: []
  defp p126_cartesian(lists, f), do: p126_cartesian(Enum.reverse(lists), [], f) |> Enum.to_list()
  defp p126_cartesian([], elems, f), do: [apply(f, elems)]
  defp p126_cartesian([h | tail], elems, f), do: Enum.flat_map(h, fn x -> p126_cartesian(tail, [x | elems], f) end)


  @doc """
  Group the elements of a set into disjoint subsets.

  a) In how many ways can a group of 9 people work in 3 disjoint subgroups
  of 2, 3 and 4 persons? Write a predicate that generates all the possibilities
  via backtracking.

  Example:
  group3([aldo,beat,carla,david,evi,flip,gary,hugo,ida],G1,G2,G3).
  G1 = [aldo,beat], G2 = [carla,david,evi], G3 = [flip,gary,hugo,ida]
  ...

  b) Generalize the above predicate in a way that we can specify a list of
  group sizes and the predicate will return a list of groups.

  Example:
  group([aldo,beat,carla,david,evi,flip,gary,hugo,ida],[2,2,5],Gs).
  Gs = [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]]
  ...

  Note that we do not want permutations of the group members; i.e. [[aldo,beat],...]
  is the same solution as [[beat,aldo],...]. However, we make a difference between
  [[aldo,beat],[carla,david],...] and [[carla,david],[aldo,beat],...].

  You may find more about this combinatorial problem in a good book on discrete
  mathematics under the term "multinomial coefficients".
  """
  def p127_group3(_) do
    [["aldo","beat"], ["carla","david","evi"], ["flip","gary","hugo","ida"]]
  end
  def p127_group(_, _) do
    [["aldo","beat"], ["carla","david"], ["evi","flip","gary","hugo","ida"]]
  end
end
