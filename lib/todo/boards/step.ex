defmodule Todo.Boards.Step do
  use Ecto.Schema

  alias Todo.Boards.Card

  schema "steps" do
    field :goal, :string
    field :done, :boolean

    belongs_to :card, Card

    timestamps()
  end
end
