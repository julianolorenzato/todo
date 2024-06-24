defmodule TodoWeb.BoardLive do
  use TodoWeb, :live_view

  alias Todo.Boards
  alias TodoWeb.SectionComponent

  def mount(_params, _session, socket) do
    new_socket =
      socket
      |> assign(temporary_section: false)
      |> assign(new_section_form: to_form(%{}))

    {:ok, new_socket}
  end

  # need remove and use JS commands
  def handle_event("toggle_temporary", _unsigned_params, socket) do
    {:noreply, assign(socket, temporary_section: !socket.assigns.temporary_section)}
  end

  def handle_event("create_section", unsigned_params, socket) do
    {:ok, created_section} = Boards.create_section(socket.assigns.board.id, unsigned_params)

    new_socket =
      socket
      |> assign(sections: socket.assigns.sections ++ [created_section])
      |> assign(temporary_section: false)

    {:noreply, new_socket}
  end

  def handle_event("delete_section", %{"id" => id, "section_id" => section_id}, socket) do
    case Boards.delete_section(section_id) do
      {1, _} -> {:noreply, assign(socket, sections: Boards.get_sections_from_board(id))}
      {0, _} -> {:noreply, socket}
    end
  end
end
