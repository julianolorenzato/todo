defmodule Todo.Boards.Card do
  use Ecto.Schema

  import Ecto.Changeset

  alias Todo.Boards.{Section, Step}

  schema "cards" do
    field :title, :string
    field :description, :string

    belongs_to :section, Section
    has_many :steps, Step

    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description])
  end
end
