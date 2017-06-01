defmodule Thebar.Recipe do
  use Thebar.Web, :model

  schema "recipes" do
    field :amount, :decimal
    field :measurement, :string
    
    belongs_to :drink, Thebar.Drink
    belongs_to :ingredient, Thebar.Ingredient

    timestamps()
  end

  @valid_attrs ~w(amount measurement drink_id ingredient_id)a
  @required_attrs ~w(amount measurement drink_id ingredient_id)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_attrs)
    |> validate_required(@required_attrs)
  end
end
