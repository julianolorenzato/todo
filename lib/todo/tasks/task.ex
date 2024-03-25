defmodule Todo.Tasks.Task do
  use Ecto.Schema

  alias Todo.Tasks.{List, Step}

  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string

    belongs_to :list, List
    has_many :steps, Step

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description])
  end
end
