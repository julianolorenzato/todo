defmodule TodoWeb.Kanban do
  alias Todo.Tasks

  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    socket =
      socket
      |> assign(boards: Tasks.get_boards())
      |> assign(sidebar: true)
      |> assign(sidebar_open: true)

    {:cont, socket}
  end
end
