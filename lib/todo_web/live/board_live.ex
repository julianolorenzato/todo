defmodule TodoWeb.BoardLive do
  use TodoWeb, :live_view

  alias TodoWeb.ListComponent
  alias Todo.Tasks.Board
  alias Todo.Repo
  alias Todo.Tasks

  def mount(%{"id" => board_id}, _session, socket) do
    new_socket =
      socket
      |> assign(board: Repo.get_by(Board, id: String.to_integer(board_id)))
      |> assign(lists: Tasks.get_lists_from_board(String.to_integer(board_id)))
      |> assign(temporary_list: false)
      |> assign(new_list_form: to_form(%{}))

    {:ok, new_socket}
  end

  def handle_event("toggle_temporary", _unsigned_params, socket) do
    # JS.focus(to: "a")
    # focus the text input element
    {:noreply, assign(socket, temporary_list: !socket.assigns.temporary_list)}
  end

  def handle_event("create_list", unsigned_params, socket) do
    {:ok, created_list} = Tasks.create_list(socket.assigns.board.id, unsigned_params)

    new_socket =
      socket
      |> assign(lists: socket.assigns.lists ++ [created_list])
      |> assign(temporary_list: false)

    {:noreply, new_socket}
  end

  def handle_event("toggle_sidebar", _unsigned_params, socket) do
    {:noreply, assign(socket, sidebar_open: !socket.assigns.sidebar_open)}
  end

  defp board_menu(assigns) do
    ~H"""
    <div class="row-s flex gap-3 py-1 px-3 items-center">
      <.header>Board <%= @board.title %></.header>
      <button class="p-1 hover:scale-110 transition-all">
        <.icon name="hero-star" />
      </button>
    </div>
    """
  end
end
