defmodule Thebar.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :amount, :decimal
      add :measurement, :string
      add :drink_id, :integer
      add :category_id, :integer

      timestamps()
    end

    create index(:recipes, [:drink_id])
    create index(:recipes, [:category_id])
  end
end
