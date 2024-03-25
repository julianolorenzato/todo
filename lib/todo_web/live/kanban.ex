defmodule TodoWeb.Kanban do
  alias Todo.Tasks

  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    boards = Tasks.get_boards()

    {:cont, assign(socket, boards: boards)}
  end
end
