defmodule TodoWeb.BoardController do
  use TodoWeb, :controller

  alias Todo.Tasks.Board
  alias Todo.Tasks

  def to_index(conn, _params), do: redirect(conn, to: ~p"/boards")

  def index(conn, _params) do
    render(conn, :index, boards: Tasks.get_boards())
  end

  def new(conn, _params) do
    render(conn, :new, changeset: Tasks.change_board(%Board{}))
  end

  def create(conn, params) do
    Tasks.create_board(params)
    redirect(conn, to: ~p"/boards")
  end
end
