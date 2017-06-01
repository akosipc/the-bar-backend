defmodule Thebar.Category do
  use Thebar.Web, :model

  schema "categories" do
    field :name

    has_many :ingredient, Thebar.Ingredient

    timestamps()
  end

  @valid_attrs ~w(name)a
  @required_attrs ~w(name)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_attrs)
    |> validate_required(@required_attrs)
  end
end
