defmodule TodoWeb.BoardsLive do
  alias Todo.Tasks
  use TodoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="bg-slate-300 p-2 flex flex-col gap-2 rounded">
      <div class="flex items-center justify-between">
        <.header>Your Boards</.header>
        <.link href={~p"/boards/new"}>
          <.button>New board</.button>
        </.link>
      </div>

      <ul class="grid grid-cols-4 gap-2">
        <li :for={{board, tasks_count} <- @boards}>
          <.board_card id={board.id} title={board.title} tasks_count={tasks_count} />
        </li>
      </ul>
    </div>
    """
  end

  attr :id, :integer, required: true
  attr :title, :string, required: true
  attr :tasks_count, :integer, required: true

  defp board_card(assigns) do
    ~H"""
    <.link href={~p"/boards/#{@id}"}>
      <div class="flex flex-col bg-white border-2 border-transparent p-2 rounded hover:border-gray-700">
        <h4><%= @title %></h4>
        <div class="flex items-center gap-1">
          <.icon name="hero-check" />
          <div>
            <%= @tasks_count %>
          </div>
        </div>
      </div>
    </.link>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(boards: Tasks.get_boards())
      |> assign(sidebar: true)
      # |> assign(sidebar_open: true)

    {:ok, socket}
  end
end
