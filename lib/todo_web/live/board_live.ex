defmodule TodoWeb.BoardLive do
  alias Ecto.Changeset
  use TodoWeb, :live_view

  alias Todo.Boards
  alias TodoWeb.SectionComponent

  def mount(_params, _session, socket) do
    new_socket =
      socket
      |> assign(new_section_form: to_form(%{}))

    {:ok, new_socket}
  end

  def handle_event("create_section", %{"title" => _} = params, socket) do
    case Boards.create_section(socket.assigns.board.id, params) do
      {:ok, created_section} ->
        new_socket =
          socket
          |> assign(sections: socket.assigns.sections ++ [created_section])
          |> assign(new_section_form: to_form(%{}))

        {:noreply, new_socket}

      {:error, changeset} ->
        {:noreply, assign(socket, new_section_form: to_form(%{}, errors: changeset.errors))}
    end
  end

  def handle_event("delete_section", %{"section_id" => section_id}, socket) do
    case Boards.delete_section(section_id) do
      {1, _} ->
        {:noreply,
         assign(socket, sections: Boards.get_sections_from_board(socket.assigns.board.id))}

      {0, _} ->
        {:noreply, socket}
    end
  end

  def handle_event("form_change", unsigned_params, socket) do
    {:noreply, assign(socket, new_section_form: to_form(unsigned_params))}
  end

  defp toggle_new_section() do
    %JS{}
    |> JS.toggle_class("hidden", to: "#new_section_form")
    |> JS.toggle_class("hero-x-mark hero-plus", to: "#toggle_new_section_icon")
  end
end
