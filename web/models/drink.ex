defmodule Thebar.Drink do
  use Thebar.Web, :model

  schema "drinks" do
    field :name, :string
    field :description, :string
    field :instructions, :string
    field :drink_type

    has_many :recipes, Thebar.Recipe
    has_many :ingredients, through: [:recipes, :ingredient]

    timestamps()
  end

  @valid_attrs ~w(name description instructions drink_type)a
  @required_attrs ~w(name description instructions)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_attrs)
    |> validate_required(@required_attrs)
  end
end
