defmodule TodoWeb.BoardHTML do
  use TodoWeb, :html

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

  def index(assigns) do
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

  def new(assigns) do
    ~H"""
    <div class="bg-white p-4 rounded">
      <div class="flex items-center justify-between">
        <.link href={~p"/boards"}>
          <.button>
            <.icon name="hero-arrow-left" />
          </.button>
        </.link>

        <.header>Create new Board</.header>

        <.button class="invisible">
          <.icon name="hero-arrow-left" />
        </.button>
      </div>

      <.form :let={f} class="flex flex-col gap-2" for={@changeset} method="POST" action={~p"/boards"}>
        <.input label="Title" name="title" field={f[:title]} />
        <.button>Create</.button>
      </.form>
    </div>
    """
  end
end
