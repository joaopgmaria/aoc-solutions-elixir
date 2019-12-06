defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  @tag day: 4
  test "validates password" do
    assert Day4.is_valid?("111111")
    assert ! Day4.is_valid?("223450")
    assert ! Day4.is_valid?("123789")
  end

  @tag day: 4
  test "validates password yet again" do
    assert Day4.is_more_valid?("112233")
    assert ! Day4.is_more_valid?("123444")
    assert Day4.is_more_valid?("111122")
  end

end
