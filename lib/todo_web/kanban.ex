defmodule TodoWeb.Kanban do
  alias Todo.Repo
  alias Todo.Boards
  alias Todo.Boards.Board

  import Plug.Conn, only: [assign: 3]
  import Phoenix.Component, only: [assign: 2]

  def on_mount(:default, %{"id" => board_id}, _session, socket) do
    socket =
      socket
      |> assign(app_header: true)
      |> assign(board: Repo.get_by(Board, id: board_id))
      |> assign(sections: Boards.get_sections_from_board(board_id))

    {:cont, socket}
  end

  def init_app_default_style(conn, _opts) do
    assign(conn, :app_header, false)
  end
end
