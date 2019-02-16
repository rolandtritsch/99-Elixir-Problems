defmodule NinetyNineProblemsTest do
  use ExUnit.Case
  doctest NinetyNineProblems

  test "p101_last(list)" do
    assert NinetyNineProblems.p101_last([1, 2, 99]) == 99
  end

  test "p102_lastBut(list)" do
    assert NinetyNineProblems.p102_last_but([1, 2, 99, 0]) == 99
  end

  test "p103_elementAt(list, k)" do
    assert NinetyNineProblems.p103_element_at([1, 2, 99, 0], 2) == 99
  end

  test "p104_length(list)" do
    assert NinetyNineProblems.p104_length([1, 2, 99, 0]) == 4
  end

  test "p105_reverse(list)" do
    assert NinetyNineProblems.p105_reverse([1, 2, 99, 0]) == [0, 99, 2, 1]
  end

  test "p106_isPalindrom(list)" do
    assert NinetyNineProblems.p106_palindrom?('racecar')
  end

  test "p107_flatten(list)" do
    assert NinetyNineProblems.p107_flatten([1, [2, 2], 1, [2, 2, [3, 3, 3]]]) == [1, 2, 2, 1, 2, 2, 3, 3, 3]
  end

  test "p108_compress(list)" do
    assert NinetyNineProblems.p108_compress([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [1, 2, 1, 2, 3]
    assert NinetyNineProblems.p108_compress('aaaabccaadeeee') == 'abcade'
  end

  test "p109_pack(list)" do
    assert NinetyNineProblems.p109_pack([1, 2, 2, 1, 2, 2, 3, 3, 3]) == [[1], [2, 2], [1], [2, 2], [3, 3, 3]]
    assert NinetyNineProblems.p109_pack('aaaabccaadeeee') == ['aaaa', 'b', 'cc', 'aa', 'd', 'eeee']
  end
end
