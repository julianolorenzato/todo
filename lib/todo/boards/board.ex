defmodule Todo.Boards.Board do
  use Ecto.Schema
  
  import Ecto.Changeset

  alias Todo.Boards.Section

  schema "boards" do
    field :title, :string

    has_many :sections, Section

    timestamps()
  end

  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_length(:title, max: 25)
  end
end
