defmodule Thebar.Repo.Migrations.CreateIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :description, :text
      add :available, :boolean, default: true
      add :alcohol_content, :integer

      add :category_id, :integer

      timestamps()
    end

    create index(:ingredients, [:category_id])
  end
end
