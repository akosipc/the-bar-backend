defmodule Thebar.Repo.Migrations.CreateDrink do
  use Ecto.Migration

  def change do
    create table(:drinks) do
      add :name, :string
      add :description, :text
      add :instructions, :text
      add :drink_type, :string

      timestamps()
    end
  end
end
