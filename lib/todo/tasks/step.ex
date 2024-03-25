defmodule Todo.Tasks.Step do
  use Ecto.Schema

  alias Todo.Tasks.Task

  schema "steps" do
    field :goal, :string
    field :done, :boolean

    belongs_to :task, Task

    timestamps()
  end
end
