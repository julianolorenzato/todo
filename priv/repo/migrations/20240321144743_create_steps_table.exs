defmodule Todo.Repo.Migrations.CreateStepsTable do
  use Ecto.Migration

  def change() do
    create table(:steps) do
      add :goal, :string, null: false
      add :done, :boolean, null: false, default: false

      add :card_id, references(:cards, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
