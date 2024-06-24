defmodule TodoWeb.Kanban do
  alias Todo.Repo
  alias Todo.Boards
  alias Todo.Boards.Board

  import Phoenix.Component

  def on_mount(:default, %{"id" => board_id}, _session, socket) do
    socket =
      socket
      |> assign(board: Repo.get_by(Board, id: String.to_integer(board_id)))
      |> assign(sections: Boards.get_sections_from_board(String.to_integer(board_id)))

    {:cont, socket}
  end
end
