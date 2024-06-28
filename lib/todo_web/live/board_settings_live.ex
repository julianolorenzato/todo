defmodule TodoWeb.BoardSettingsLive do
  use TodoWeb, :live_view

  alias Todo.Boards

  def mount(params, session, socket) do
    socket =
      socket
      |> assign(members: Boards.get_board_members(socket.assigns.board.id))
      |> assign(join_links: Boards.get_board_join_links(socket.assigns.board.id))
      |> assign(new_join_link_form: to_form(%{}))

    {:ok, socket}
  end

  def handle_params(unsigned_params, uri, socket) do
    {:noreply, socket}
  end

  def handle_event("create_join_link", unsigned_params, socket) do
    Boards.create_join_link(unsigned_params, nil, socket.assigns.board.id)
  end

  def settings_view(%{type: :info} = assigns) do
    ~H"""
    <h1>Info</h1>
    """
  end

  def settings_view(%{type: :members} = assigns) do
    ~H"""
    <div class="mt-4 bg-gray-200 p-2 overflow-hidden rounded-md shadow-md">
      <ul>
        <li :for={member <- @members} class="flex gap-2">
          <img width="70" src={"https://api.dicebear.com/9.x/lorelei/svg?seed=#{member.user.id}"} />
          <div class="flex flex-col">
            <span class="text-lg"><%= member.user.first_name %> <%= member.user.last_name %></span>
            <span class="text-md text-gray-700"><%= member.user.email %></span>
            <span class="text-md font-bold"><%= String.capitalize(to_string(member.role)) %></span>
          </div>
        </li>
      </ul>
    </div>
    """
  end

  def settings_view(%{type: :join_links} = assigns) do
    ~H"""
    <div class="mt-4 flex flex-col gap-2">
      <.form phx-submit="create_join_link" class="card w-60 p-4 gap-2 flex flex-col">
        <.header>New join link</.header>
        <.input
          type="select"
          options={[
            {"1 hour", "1-hour"},
            {"12 hours", "12-hour"},
            {"1 day", "1-day"},
            {"7 days", "7-day"}
          ]}
          label="Expiration date"
          field={@new_join_link_form[:minutes_until_expiration]}
        />
        <.button>Criar</.button>
      </.form>

      <ul>
        <li :for={join_link <- @join_links}>
          <%= join_link.minutes_until_expiration %>
        </li>
      </ul>
    </div>
    """
  end
end
