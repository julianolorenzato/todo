defmodule Todo.Boards.JoinLink do
  use Ecto.Schema

  alias Todo.Boards.{Board, EctoDuration}

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "join_links" do
    field :minutes_until_expiration, EctoDuration

    belongs_to :board, Board

    timestamps()
  end

  def create_changeset(join_link, attrs) do
    join_link
    |> cast(attrs, [:minutes_until_expiration])
  end
end
