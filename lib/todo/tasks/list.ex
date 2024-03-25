defmodule Todo.Tasks.List do
  use Ecto.Schema

  alias Todo.Tasks.{List, Board, Task}

  import Ecto.Changeset

  schema "lists" do
    field :title, :string

    belongs_to :board, Board
    has_many :tasks, Task

    timestamps()
  end

  def changeset(%List{} = list, attrs) do
    list
    |> cast(attrs, [:title])
    |> validate_length(:title, max: 20)
  end
end
