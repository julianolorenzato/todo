defmodule TodoWeb.BoardHTML do
  use TodoWeb, :html

  attr :id, :integer, required: true
  attr :title, :string, required: true
  attr :tasks_count, :integer, required: true

  defp board_card(assigns) do
    ~H"""
    <.link href={~p"/boards/#{@id}"}>
      <div class="flex flex-col bg-gray-800 text-white border-2 border-transparent p-2 rounded hover:border-gray-300">
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
    <div class="bg-white p-2 flex flex-col gap-2 rounded">
      <div class="flex items-center justify-between">
        <.header>Your Boards</.header>
        <.link href={~p"/boards/new"}>
          <.button>New board</.button>
        </.link>
      </div>

      <%= if @boards == [] do %>
        <div class="p-4">
          You do not have any board yet, try creating one.
        </div>
      <% else %>
        <ul class="grid grid-cols-4 gap-2">
          <li :for={{board, tasks_count} <- @boards}>
            <.board_card id={board.id} title={board.title} tasks_count={tasks_count} />
          </li>
        </ul>
      <% end %>
    </div>
    """
  end

  def new(assigns) do
    ~H"""
    <div class="bg-white p-2 rounded">
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

      <div class="flex justify-center">
        <.form
          :let={f}
          for={@changeset}
          method="POST"
          action={~p"/boards"}
          class="w-80 bg-gray-300 p-2 rounded flex flex-col gap-2"
        >
          <.input label="Title" name="title" field={f[:title]} />
          <.button>Create</.button>
        </.form>
      </div>
    </div>
    """
  end
end
