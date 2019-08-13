defmodule TelnyxTest do
  use ExUnit.Case
  doctest Telnyx

  test "greets the world" do
    assert Telnyx.hello() == :world
  end
end
