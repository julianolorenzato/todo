defmodule Todo.Boards.Member do
  use Ecto.Schema
  import Ecto.Changeset

  @role_enum [:owner, :admin, :partner, :viewer]

  schema "members" do
    field :role, Ecto.Enum, values: @role_enum, default: :viewer

    belongs_to :user, Todo.Accounts.User
    belongs_to :board, Todo.Boards.Board

    timestamps()
  end

  def changeset(%__MODULE__{} = member, attrs) do
    member
    |> cast(attrs, [:role])
    |> validate_inclusion(:role, @role_enum)
  end
end
