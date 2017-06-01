defmodule Thebar.Ingredient do
  use Thebar.Web, :model

  schema "ingredients" do
    field :name, :string
    field :description, :string
    field :available, :boolean
    field :alcohol_content, :decimal

    has_many :recipes, Thebar.Recipe
    has_many :drinks, through: [:recipes, :drink]
    belongs_to :category, Thebar.Category

    timestamps()
  end

  @valid_attrs ~w(name description available alcohol_content category_id)a
  @required_attrs ~w(name description alcohol_content category_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @valid_attrs)
    |> validate_required(@required_attrs)
  end
end
