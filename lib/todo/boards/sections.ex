defmodule Todo.Boards.Section do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Boards.{Section, Board, Card}

  schema "sections" do
    field :title, :string

    belongs_to :board, Board
    has_many :cards, Card

    timestamps()
  end

  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:title])
    |> validate_length(:title, max: 20)
  end
end
