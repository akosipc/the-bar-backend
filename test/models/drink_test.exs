defmodule Thebar.DrinkTest do
  use Thebar.ModelCase

  alias Thebar.Drink

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Drink.changeset(%Drink{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Drink.changeset(%Drink{}, @invalid_attrs)
    refute changeset.valid?
  end
end
