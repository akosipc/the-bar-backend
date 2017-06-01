defmodule Thebar.Repo.Migrations.ChangesAlcholContentToDecimal do
  use Ecto.Migration

  def change do
    alter table(:ingredients) do
      modify :alcohol_content, :decimal
    end

  end
end
