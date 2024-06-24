defmodule Todo.Repo.Migrations.CreateCardsTable do
  use Ecto.Migration

  def change() do
    create table(:cards) do
      add :title, :string, null: false
      add :description, :string, size: 1000, null: true
      add :deadline, :date, null: true, default: nil

      add :section_id, references(:sections, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
