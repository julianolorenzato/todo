defmodule TodoWeb.SectionComponent do
  use TodoWeb, :live_component

  alias Todo.Boards
  alias TodoWeb.CardComponent

  def render(assigns) do
    ~H"""
    <div class="h-full overflow-hidden">
      <div class="w-60 max-h-full gap-2 flex flex-col card p-2">
        <%!-- Header --%>
        <div class="flex justify-between">
          <h3><%= @section.title %></h3>
          <button phx-click="delete_section" phx-target={@myself} phx-value-id={@section.id} class="hover:bg-red-800 hover:text-white rounded px-0.5">
            <.icon name="hero-x-mark" />
          </button>
        </div>

        <%!-- Section data --%>
        <ul class="flex flex-col gap-2 overflow-y-auto h-full fancy-scrollbar pr-2">
          <.live_component :for={card <- @cards} module={CardComponent} id={card.id} card={card} />
        </ul>

        <%!-- New card --%>
        <div
          class={[
            "self-center p-1 rounded-full",
            "flex flex-col items-center",
            "bg-neutral-300 hover:bg-neutral-200",
            "border border-slate-600",
            "transition-all cursor-pointer"
          ]}
          phx-click="toggle_new_card"
          phx-target={@myself}
        >
          <%= if @is_new_card_open do %>
            <.icon class="text-slate-600" name="hero-x-mark" />
          <% else %>
            <.icon class="text-slate-600" name="hero-plus" />
          <% end %>
        </div>

        <.form
          :if={@is_new_card_open}
          class={[
            "flex flex-col gap-2",
            "p-2 rounded",
            "bg-neutral-300",
            "border border-slate-600"
          ]}
          phx-target={@myself}
          phx-submit="create_card"
          for={@new_card_form}
        >
          <.input type="text" name="title" label="Card Title" field={@new_card_form[:title]} />
          <.button>Create</.button>
        </.form>
      </div>
    </div>
    """
  end

  def mount(socket) do
    new_socket =
      socket
      |> assign(new_card_form: to_form(%{}))
      |> assign(is_new_card_open: false)

    {:ok, new_socket}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, cards: Boards.get_cards_from_section(assigns.section.id), section: assigns.section)}
  end

  def handle_event("toggle_new_card", _unsigned_params, socket) do
    {:noreply, assign(socket, is_new_card_open: !socket.assigns.is_new_card_open)}
  end

  def handle_event("create_card", unsigned_params, socket) do
    Boards.create_card(socket.assigns.section.id, unsigned_params)

    {:noreply, socket}
  end
end
