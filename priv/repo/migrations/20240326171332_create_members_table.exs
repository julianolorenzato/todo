defmodule Todo.Repo.Migrations.CreateMembersTable do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :role, :string, null: false

      add :board_id, references(:boards, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:members, [:board_id, :user_id])
  end
end
