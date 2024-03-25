defmodule Todo.Repo.Migrations.CreateTasksTable do
  use Ecto.Migration

  def change() do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :string, size: 1000, null: true
      add :deadline, :date, null: true, default: nil

      add :list_id, references(:lists, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
