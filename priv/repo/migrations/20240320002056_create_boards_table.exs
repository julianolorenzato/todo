defmodule Todo.Repo.Migrations.CreateBoardsTable do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :title, :string, null: false

      timestamps()
    end
  end
end
