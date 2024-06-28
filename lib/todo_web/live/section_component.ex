defmodule TodoWeb.SectionComponent do
  use TodoWeb, :live_component

  alias Todo.Boards
  alias TodoWeb.CardComponent
  alias Phoenix.LiveView.JS

  def mount(socket) do
    new_socket =
      socket
      |> assign(new_card_form: to_form(%{}))

    {:ok, new_socket}
  end

  def update(assigns, socket) do
    {:ok,
     assign(socket,
       cards: Boards.get_cards_from_section(assigns.section.id),
       section: assigns.section
     )}
  end

  def handle_event("create_card", unsigned_params, socket) do
    {:ok, created_card} = Boards.create_card(socket.assigns.section.id, unsigned_params)

    {:noreply, assign(socket, cards: socket.assigns.cards ++ [created_card])}
  end

  defp toggle_new_card(section_id) do
    %JS{}
    |> JS.toggle_class("hero-x-mark hero-plus", to: "#toggle_new_card_btn#{section_id}")
    |> JS.toggle_class("hidden", to: "#new_card_form#{section_id}")
  end
end
