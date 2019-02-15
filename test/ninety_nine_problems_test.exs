defmodule NinetyNineProblemsTest do
  use ExUnit.Case
  doctest NinetyNineProblems

  test "p101_last(list)" do
    assert NinetyNineProblems.p101_last([1, 2, 99]) == 99
  end
end
