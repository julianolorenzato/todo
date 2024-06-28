defmodule TodoWeb.BoardController do
  use TodoWeb, :controller

  alias Todo.Boards
  alias Todo.Boards.{Board, Member}

  def index(conn, _params) do
    render(conn, :index, boards: Boards.get_boards_by_user_id(conn.assigns.current_user.id))
  end

  def new(conn, _params) do
    render(conn, :new, changeset: Boards.change_board(%Board{}))
  end

  def create(conn, params) do
    Boards.create_board(params, conn.assigns.current_user)
    redirect(conn, to: ~p"/boards")
  end
end
