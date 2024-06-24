defmodule Todo.Repo.Migrations.CreateSectionsTable do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :title, :string, null: false

      add :board_id, references(:boards, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
