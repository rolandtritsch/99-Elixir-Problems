defmodule NinetyNineProblemsTest do
  use ExUnit.Case
  doctest NinetyNineProblems

  test "p101_last(list)" do
    assert NinetyNineProblems.p101_last([1, 2, 99]) == 99
  end

  test "p102_lastBut(list)" do
    assert NinetyNineProblems.p102_lastBut([1, 2, 99, 0]) == 99
  end

  test "p103_elementAt(list, k)" do
    assert NinetyNineProblems.p103_elementAt([1, 2, 99, 0], 2) == 99
  end

  test "p104_length(list)" do
    assert NinetyNineProblems.p104_length([1, 2, 99, 0]) == 4
  end
end
