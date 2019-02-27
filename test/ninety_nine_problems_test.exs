defmodule NinetyNineProblemsTest do
  use ExUnit.Case

  doctest NinetyNineProblems

  import NinetyNineProblems

  test "p101_last(list)" do
    assert p101_last([1, 2, 99]) == 99
  end

  test "p102_lastBut(list)" do
    assert p102_last_but([1, 2, 99, 0]) == 99
  end

  test "p103_elementAt(list, k)" do
    assert p103_element_at([1, 2, 99, 0], 2) == 99
  end

  test "p104_length(list)" do
    assert p104_length([1, 2, 99, 0]) == 4
  end

  test "p105_reverse(list)" do
    assert p105_reverse([1, 2, 99, 0]) == [0, 99, 2, 1]
  end

  test "p106_isPalindrom(list)" do
    assert p106_palindrom?('racecar')
  end

  test "p107_flatten(list)" do
    assert p107_flatten([1, [2, 2], 1, [2, 2, [3, 3, 3]]]) == [1, 2, 2, 1, 2, 2, 3, 3, 3]
  end

  test "p108_compress(list)" do
    assert p108_compress([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [1, 2, 1, 2, 3]
    assert p108_compress(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == ['a','b','c','a','d','e']
  end

  test "p109_pack(list)" do
    assert p109_pack([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [[1], [2, 2], [1], [2, 2], [3, 3, 3]]
    assert p109_pack(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == [['a','a','a','a'], ['b'], ['c','c'], ['a','a'], ['d'], ['e','e','e','e']]
  end

  test "p110_encode(list)" do
    assert p110_encode(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == [{4, 'a'}, {1, 'b'}, {2, 'c'}, {2, 'a'}, {1, 'd'}, {4, 'e'}]
  end

  test "p111_encode_modified(list)" do
    assert p111_encode_modified(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == [{4, 'a'}, 'b', {2, 'c'}, {2, 'a'}, 'd', {4, 'e'}]
  end

  test "p112_decode(list)" do
    assert p112_decode([{4, 'a'}, 'b', {2, 'c'}, {2, 'a'}, 'd', {4, 'e'}]) == ['a','a','a','a','b','c','c','a','a','d','e','e','e','e']
    assert p111_encode_modified('aaaabccaadeeee') |> p112_decode == 'aaaabccaadeeee'
  end

  test "p113_encode_direct(list)" do
    assert p113_encode_direct(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == [{4, 'a'}, 'b', {2, 'c'}, {2, 'a'}, 'd', {4, 'e'}]
  end

  test "p114_duplicate(list)" do
    assert p114_duplicate(['a','b','c','c','d']) == ['a','a','b','b','c','c','c','c','d','d']
  end

  test "p115_duplicate_n(list)" do
    assert p115_duplicate_n(['a','b','c'], 3) == ['a','a','a','b','b','b','c','c','c']
  end

  test "p116_drop_every(list, n)" do
    assert p116_drop_every(['a','b','c','d','e','f','g','h','i','k'], 3) == ['a','b','d','e','g','h','k']
  end

  test "p117_split_at(list, n)" do
    assert p117_split_at(['a','b','c','d','e','f','g','h','i','k'], 3) == {['a','b','c'], ['d','e','f','g','h','i','k']}
  end

  test "p118_slice(list, i, k)" do
    assert p118_slice(['a','b','c','d','e','f','g','h','i','k'], 3, 7) == ['c','d','e','f','g']
  end

  test "p119_rotate_n(list, n)" do
    assert p119_rotate_n(['a','b','c','d','e','f','g','h'], 3) == ['d','e','f','g','h','a','b','c']
    assert p119_rotate_n(['a','b','c','d','e','f','g','h'], -2) == ['g','h','a','b','c','d','e','f']
  end

  test "p120_remove_at(list, k)" do
    assert p120_remove_at(['a','b','c','d'], 2) == {'b', ['a','c','d']}
  end

  test "p121_insert_at(list, k, e)" do
    assert p121_insert_at(['a','b','c','d'], 2, 'z') == ['a','z','b','c','d']
  end

  test "p122_range(from, to)" do
    assert p122_range(4,9) == [4,5,6,7,8,9]
  end

  test "p123_random_select_n(l, n)" do
    assert p123_random_select_n(['a','b','c','d','e','f','g','h'], 3) == ['e','h','b']
  end

  test "p124_lotto_n_m(n, m)" do
    assert p124_lotto_n_m(6, 49) == [49, 45, 41, 28, 43, 12]
  end

  test "p125_random_permutation(l)" do
    assert p125_random_permutation(['a','b','c','d','e','f']) == ['a', 'c', 'e', 'd', 'f', 'b']
  end

  test "p126_combination_n(l, n)" do
    assert p126_combination_n(['a','b','c'], 3) == [['a','b','c']]
    assert p126_combination_n(['a','b','c','d','e','f'], 3) == [['a', 'b', 'c'], ['a', 'b', 'd'], ['a', 'b', 'e'], ['a', 'b', 'f'], ['a', 'c', 'd'], ['a', 'c', 'e'], ['a', 'c', 'f'], ['a', 'd', 'e'], ['a', 'd', 'f'], ['a', 'e', 'f'], ['b', 'c', 'd'], ['b', 'c', 'e'], ['b', 'c', 'f'], ['b', 'd', 'e'], ['b', 'd', 'f'], ['b', 'e', 'f'], ['c', 'd', 'e'], ['c', 'd', 'f'], ['c', 'e', 'f'], ['d', 'e', 'f']]
  end

  test "p127_group(ls, gs)" do
    assert p127_group3(["aldo","beat","carla","david","evi","flip","gary","hugo","ida"]) == [["aldo","beat"], ["carla","david","evi"], ["flip","gary","hugo","ida"]]
    assert p127_group(["aldo","beat","carla","david","evi","flip","gary","hugo","ida"], [2,2,5]) == [["aldo","beat"], ["carla","david"], ["evi","flip","gary","hugo","ida"]]
  end

  test "p128_lsort(ls)" do
    assert p128_lsort([['a','b','c'],['d','e'],['f','g','h'],['d','e'],['i','j','k','l'],['m','n'],['o']])  == [['o'], ['d','e'], ['d','e'], ['m','n'], ['a','b','c'], ['f','g','h'], ['i','j','k','l']]
    assert p128_lfsort([['a','b','c'],['d','e'],['f','g','h'],['d','e'],['i','j','k','l'],['m','n'],['o']]) == [['o'], ['i','j','k','l'], ['a','b','c'], ['f','g','h'], ['d','e'], ['d','e'], ['m','n']]
  end
end
