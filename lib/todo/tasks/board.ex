defmodule Todo.Tasks.Board do
  alias Todo.Tasks.List
  use Ecto.Schema

  import Ecto.Changeset

  schema "boards" do
    field :title, :string

    has_many :lists, List

    timestamps()
  end

  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_length(:title, max: 25)
  end
end
