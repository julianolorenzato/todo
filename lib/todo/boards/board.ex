defmodule Todo.Boards.Board do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Boards.{Section, Member, JoinLink}

  schema "boards" do
    field :title, :string

    has_many :sections, Section
    has_many :members, Member
    has_many :join_links, JoinLink

    timestamps()
  end

  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_length(:title, max: 25)
  end
end
