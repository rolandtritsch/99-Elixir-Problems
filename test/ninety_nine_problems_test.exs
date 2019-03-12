defmodule NinetyNineProblemsTest do
  use ExUnit.Case
  use ExUnitProperties

  doctest NinetyNineProblems

  import NinetyNineProblems

  property "Last element must always be last :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 1) do
      assert p101_last(l) == List.last(l)
    end
  end

  test "p101_last(list)" do
    assert p101_last([1, 2, 99]) == 99
  end

  property "But last element must always be but last :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 2) do
      assert p102_last_but(l) == Enum.at(l, length(l) - 2)
    end
  end

  test "p102_last_but(list)" do
    assert p102_last_but([1, 2, 99, 0]) == 99
  end

  property "Element at k must always be at k :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 1),
              k <- StreamData.positive_integer(),
              k_ = rem(k, length(l)) do
      assert p103_element_at(l, k_) == Enum.at(l, k_)
    end
  end

  test "p103_element_at(list, k)" do
    assert p103_element_at([1, 2, 99, 0], 2) == 99
  end

  property "Length must always be length :)" do
    check all l <- StreamData.list_of(StreamData.integer()) do
      assert p104_length(l) == length(l)
    end
  end

  test "p104_length(list)" do
    assert p104_length([1, 2, 99, 0]) == 4
  end

  property "Reverse a list twice is the list again" do
    check all l <- StreamData.list_of(StreamData.integer()) do
      assert l |> p105_reverse |> p105_reverse == l
    end
  end

  test "p105_reverse(list)" do
    assert p105_reverse([1, 2, 99, 0]) == [0, 99, 2, 1]
  end

  property "Palindroms are palindroms :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              n <- StreamData.integer(),
              p = l ++ [n] ++ Enum.reverse(l) do
      assert p106_palindrom?(p)
    end
  end

  test "p106_isPalindrom(list)" do
    assert p106_palindrom?('racecar')
  end

  property "Flatten must flatten :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              l_ = Enum.map(l, &[&1]) do
      assert p107_flatten(l_) == List.flatten(l_)
    end
  end

  test "p107_flatten(list)" do
    assert p107_flatten([1, [2, 2], 1, [2, 2, [3, 3, 3]]]) == [1, 2, 2, 1, 2, 2, 3, 3, 3]
  end

  property "Compress must dedup :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              l_ = Enum.sort(l) do
      assert p108_compress(l_) == Enum.dedup(l_)
    end
  end

  test "p108_compress(list)" do
    assert p108_compress([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [1, 2, 1, 2, 3]

    assert p108_compress('aaaabccaadeeee') == [?a, ?b, ?c, ?a, ?d, ?e]
  end

  property "Pack must pack :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 1),
              l_ = Enum.sort(l) do
      same = fn
        e, [a | rest] when e == a -> {:cont, [e | [a | rest]]}
        e, acc -> {:cont, acc, [e]}
      end

      finalize = fn acc -> {:cont, acc, []} end
      [head | tail] = l_

      assert p109_pack(l_) == Enum.chunk_while(tail, [head], same, finalize)
    end
  end

  test "p109_pack(list)" do
    assert p109_pack([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [[1], [2, 2], [1], [2, 2], [3, 3, 3]]

    assert p109_pack('aaaabccaadeeee') == [
             [?a, ?a, ?a, ?a],
             [?b],
             [?c, ?c],
             [?a, ?a],
             [?d],
             [?e, ?e, ?e, ?e]
           ]
  end

  test "p110_encode(list)" do
    assert p110_encode('aaaabccaadeeee') == [
             {4, ?a},
             {1, ?b},
             {2, ?c},
             {2, ?a},
             {1, ?d},
             {4, ?e}
           ]
  end

  test "p111_encode_modified(list)" do
    assert p111_encode_modified('aaaabccaadeeee') == [
             {4, ?a},
             ?b,
             {2, ?c},
             {2, ?a},
             ?d,
             {4, ?e}
           ]
  end

  test "p112_decode(list)" do
    assert p112_decode([{4, 'a'}, 'b', {2, 'c'}, {2, 'a'}, 'd', {4, 'e'}]) ==
             ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']

    assert p111_encode_modified('aaaabccaadeeee') |> p112_decode == 'aaaabccaadeeee'
  end

  test "p113_encode_direct(list)" do
    assert p113_encode_direct('aaaabccaadeeee') ==
             [{4, ?a}, ?b, {2, ?c}, {2, ?a}, ?d, {4, ?e}]
  end

  property "Duplicate must duplicate :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 1) do
      assert p114_duplicate(l) |> Enum.sort() ==
               List.duplicate(l, 2) |> List.flatten() |> Enum.sort()
    end
  end

  test "p114_duplicate(list)" do
    assert p114_duplicate('abccd') == [?a, ?a, ?b, ?b, ?c, ?c, ?c, ?c, ?d, ?d]
  end

  property "Duplicate must duplicate (n times) :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 1),
              n <- StreamData.positive_integer() do
      assert p115_duplicate_n(l, n) |> Enum.sort() ==
               List.duplicate(l, n) |> List.flatten() |> Enum.sort()
    end
  end

  test "p115_duplicate_n(list)" do
    assert p115_duplicate_n('abc', 3) == [?a, ?a, ?a, ?b, ?b, ?b, ?c, ?c, ?c]
  end

  property "Drop must drop :)" do
    check all l <- StreamData.list_of(StreamData.integer(), min_length: 3),
              n <- StreamData.integer(2..(length(l) - 1)) do
      assert p116_drop_every(List.delete_at(l, 0), n) == Enum.drop_every(l, n)
    end
  end

  test "p116_drop_every(list, n)" do
    assert Enum.to_list(1..10) |> p116_drop_every(2) == [1, 3, 5, 7, 9]
    assert Enum.to_list(1..10) |> Enum.drop_every(2) == [2, 4, 6, 8, 10]

    assert p116_drop_every('abcdefghik', 3) == [?a, ?b, ?d, ?e, ?g, ?h, ?k]
  end

  property "Split must split :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              n <- StreamData.integer(0..(length(l) - 1)) do
      assert p117_split_at(l, n) == Enum.split(l, n)
    end
  end

  test "p117_split_at(list, n)" do
    assert p117_split_at('abcdefghik', 3) == {
             [?a, ?b, ?c],
             [?d, ?e, ?f, ?g, ?h, ?i, ?k]
           }
  end

  property "Slice must sclice :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              i <- StreamData.integer(0..(length(l) - 1)),
              k <- StreamData.integer((i + 1)..(length(l) - 1)) do
      assert p118_slice(l, i + 1, k + 1) == Enum.slice(l, i, k - i + 1)
    end
  end

  test "p118_slice(list, i, k)" do
    assert p118_slice('abcdefghik', 3, 7) == [?c, ?d, ?e, ?f, ?g]
  end

  test "p119_rotate_n(list, n)" do
    assert p119_rotate_n('abcdefgh', 3) == [?d, ?e, ?f, ?g, ?h, ?a, ?b, ?c]
    assert p119_rotate_n('abcdefgh', -2) == [?g, ?h, ?a, ?b, ?c, ?d, ?e, ?f]
  end

  property "Remove must remove :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              k <- StreamData.integer(0..(length(l) - 1)) do
      assert p120_remove_at(l, k + 1) |> elem(1) == List.delete_at(l, k)
    end
  end

  test "p120_remove_at(list, k)" do
    assert p120_remove_at('abcd', 2) == {?b, [?a, ?c, ?d]}
  end

  property "Insert must insert :)" do
    check all l <- StreamData.list_of(StreamData.integer()),
              k <- StreamData.integer(0..(length(l) - 1)),
              e <- StreamData.integer() do
      assert p121_insert_at(l, k + 1, e) == List.insert_at(l, k, e)
    end
  end

  test "p121_insert_at(list, k, e)" do
    assert p121_insert_at('abcd', 2, ?z) == [?a, ?z, ?b, ?c, ?d]
  end

  property "Range is a range :)" do
    check all from <- StreamData.integer(),
              to <- StreamData.integer() do
      assert p122_range(from, to) == Enum.to_list(from..to)
    end
  end

  test "p122_range(from, to)" do
    assert p122_range(4, 9) == [4, 5, 6, 7, 8, 9]
  end

  test "p123_random_select_n(l, n)" do
    assert p123_random_select_n('abcdefgh', 3) == [?e, ?h, ?b]
  end

  test "p124_lotto_n_m(n, m)" do
    assert p124_lotto_n_m(6, 49) == [49, 45, 41, 28, 43, 12]
  end

  test "p125_random_permutation(l)" do
    assert p125_random_permutation('abcdef') == [?a, ?c, ?e, ?d, ?f, ?b]
  end

  test "p126_combination_n(l, n)" do
    assert p126_combination_n('abc', 3) == [[?a, ?b, ?c]]

    assert p126_combination_n('abcdef', 3) == [
             [?a, ?b, ?c],
             [?a, ?b, ?d],
             [?a, ?b, ?e],
             [?a, ?b, ?f],
             [?a, ?c, ?d],
             [?a, ?c, ?e],
             [?a, ?c, ?f],
             [?a, ?d, ?e],
             [?a, ?d, ?f],
             [?a, ?e, ?f],
             [?b, ?c, ?d],
             [?b, ?c, ?e],
             [?b, ?c, ?f],
             [?b, ?d, ?e],
             [?b, ?d, ?f],
             [?b, ?e, ?f],
             [?c, ?d, ?e],
             [?c, ?d, ?f],
             [?c, ?e, ?f],
             [?d, ?e, ?f]
           ]
  end

  test "p127_group(ls, gs)" do
    l = ["aldo", "beat", "carla", "david", "evi", "flip", "gary", "hugo", "ida"]

    result = [["aldo", "beat"], ["carla", "david", "evi"], ["flip", "gary", "hugo", "ida"]]
    assert p127_group3(l) == result

    result2 = [["aldo", "beat"], ["carla", "david"], ["evi", "flip", "gary", "hugo", "ida"]]
    assert p127_group(l, [2, 2, 5]) == result2
  end

  test "p128_lsort(ls)" do
    l = [['a', 'b', 'c'], ['d', 'e'], ['f', 'g', 'h'], ['d', 'e'], ['i', 'j', 'k', 'l'], ['m', 'n'], ['o']]

    result = [['o'], ['d', 'e'], ['d', 'e'], ['m', 'n'], ['a', 'b', 'c'], ['f', 'g', 'h'], ['i', 'j', 'k', 'l']]
    assert p128_lsort(l) == result

    result2 = [['o'], ['i', 'j', 'k', 'l'], ['a', 'b', 'c'], ['f', 'g', 'h'], ['d', 'e'], ['d', 'e'], ['m', 'n']]
    assert p128_lfsort(l) == result2
  end
end
