defmodule ExLibraTest do
  use ExUnit.Case
  doctest ExLibra

  test "greets the world" do
    assert ExLibra.hello() == :world
  end
end
