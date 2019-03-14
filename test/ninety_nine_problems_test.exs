defmodule NinetyNineProblemsTest do
  use ExUnit.Case
  use ExCheck

  doctest NinetyNineProblems

  import NinetyNineProblems

  property :last_must_be_last do
    for_all l in list(int()) do
      implies length(l) > 0 do
        p101_last(l) == List.last(l)
      end
    end
  end

  test "p101_last(list)" do
    assert p101_last([1, 2, 99]) == 99
  end

  property :last_bat_last_must_be_last do
    for_all l in list(int()) do
      implies length(l) > 2 do
        p102_last_but(l) == Enum.at(l, length(l) - 2)
      end
    end
  end

  test "p102_last_but(list)" do
    assert p102_last_but([1, 2, 99, 0]) == 99
  end

  property :element_at_k_is_at_k do
    for_all {l, k} in {list(int()), pos_integer()} do
      implies length(l) > 0 do
        k_ = rem(k, length(l))
        p103_element_at(l, k_) == Enum.at(l, k_)
      end
    end
  end

  test "p103_element_at(list, k)" do
    assert p103_element_at([1, 2, 99, 0], 2) == 99
  end

  property :length_must_be_length do
    for_all l in list(int()) do
      p104_length(l) == length(l)
    end
  end

  test "p104_length(list)" do
    assert p104_length([1, 2, 99, 0]) == 4
  end

  property :reverse_reverse_returns_the_list do
    for_all l in list(int()) do
      l |> p105_reverse |> p105_reverse == l
    end
  end

  test "p105_reverse(list)" do
    assert p105_reverse([1, 2, 99, 0]) == [0, 99, 2, 1]
  end

  property :palindroms_are_palindroms do
    for_all {l, n} in {list(int()), int()} do
      p = l ++ [n] ++ Enum.reverse(l)
      p106_palindrom?(p)
    end
  end

  test "p106_isPalindrom(list)" do
    assert p106_palindrom?('racecar')
  end

  property :flatten_must_flatten do
    for_all l in list(int()) do
      l_ = Enum.map(l, &[&1])
      p107_flatten(l_) == List.flatten(l_)
    end
  end

  test "p107_flatten(list)" do
    assert p107_flatten([1, [2, 2], 1, [2, 2, [3, 3, 3]]]) == [1, 2, 2, 1, 2, 2, 3, 3, 3]
  end

  property :compress_must_dedup do
    for_all l in list(int()) do
      l_ = Enum.sort(l)
      p108_compress(l_) == Enum.dedup(l_)
    end
  end

  test "p108_compress(list)" do
    assert p108_compress([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [1, 2, 1, 2, 3]

    assert p108_compress('aaaabccaadeeee') == [?a, ?b, ?c, ?a, ?d, ?e]
  end

  property "Pack must pack :)" do
    for_all l in list(int()) do
      implies length(l) > 0 do
        l_ = Enum.sort(l)
        same = fn
          e, [a | rest] when e == a -> {:cont, [e | [a | rest]]}
          e, acc -> {:cont, acc, [e]}
        end

        finalize = fn acc -> {:cont, acc, []} end
        [head | tail] = l_

        p109_pack(l_) == Enum.chunk_while(tail, [head], same, finalize)
      end
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

  property :decode_encode_is_the_string do
    for_all l in list(char()) do
      implies length(l) > 0 do
        to_charlist(l) |> p111_encode_modified |> p112_decode == to_charlist(l)
      end
    end
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

  property :duplicate_must_duplicate do
    for_all l in list(int()) do
      implies length(l) > 0 do
        l |> p114_duplicate() |> Enum.sort() == l |> List.duplicate(2) |> List.flatten() |> Enum.sort()
      end
    end
  end

  test "p114_duplicate(list)" do
    assert p114_duplicate('abccd') == [?a, ?a, ?b, ?b, ?c, ?c, ?c, ?c, ?d, ?d]
  end

  property :duplicate_must_duplicate_n_times do
    for_all {l, n} in {list(int()), pos_integer()} do
      implies length(l) > 0 do
        l |> p115_duplicate_n(n) |> Enum.sort() == l |> List.duplicate(n) |> List.flatten() |> Enum.sort()
      end
    end
  end

  test "p115_duplicate_n(list)" do
    assert p115_duplicate_n('abc', 3) == [?a, ?a, ?a, ?b, ?b, ?b, ?c, ?c, ?c]
  end

  test "p116_drop_every(list, n)" do
    assert Enum.to_list(1..10) |> p116_drop_every(2) == [1, 3, 5, 7, 9]
    assert Enum.to_list(1..10) |> Enum.drop_every(2) == [2, 4, 6, 8, 10]

    assert p116_drop_every('abcdefghik', 3) == [?a, ?b, ?d, ?e, ?g, ?h, ?k]
  end

  test "p117_split_at(list, n)" do
    assert p117_split_at('abcdefghik', 3) == {
             [?a, ?b, ?c],
             [?d, ?e, ?f, ?g, ?h, ?i, ?k]
           }
  end

  test "p118_slice(list, i, k)" do
    assert p118_slice('abcdefghik', 3, 7) == [?c, ?d, ?e, ?f, ?g]
  end

  test "p119_rotate_n(list, n)" do
    assert p119_rotate_n('abcdefgh', 3) == [?d, ?e, ?f, ?g, ?h, ?a, ?b, ?c]
    assert p119_rotate_n('abcdefgh', -2) == [?g, ?h, ?a, ?b, ?c, ?d, ?e, ?f]
  end

  test "p120_remove_at(list, k)" do
    assert p120_remove_at('abcd', 2) == {?b, [?a, ?c, ?d]}
  end

  test "p121_insert_at(list, k, e)" do
    assert p121_insert_at('abcd', 2, ?z) == [?a, ?z, ?b, ?c, ?d]
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
