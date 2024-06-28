defmodule Todo.Repo.Migrations.CreateJoinLinksTable do
  use Ecto.Migration

  def change do
    create table(:join_links, primary_key: [name: :id, type: :binary_id]) do
      add :minutes_until_expiration, :integer, null: false

      add :board_id, references(:boards, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
