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
  end

  test "p113_encode_direct(list)" do
    assert p113_encode_direct(['a','a','a','a','b','c','c','a','a','d','e','e','e','e']) == [{4, 'a'}, 'b', {2, 'c'}, {2, 'a'}, 'd', {4, 'e'}]
  end

  test "p114_dupli(list)" do
    assert p114_dupli(['a','b','c','c','d']) == ['a','a','b','b','c','c','c','c','d','d']
  end

  test "p115_dupli_n(list)" do
    assert p115_dupli_n(['a','b','c'], 3) == ['a','a','a','b','b','b','c','c','c']
  end
end
