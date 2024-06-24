defmodule TodoWeb.KanbanComponents do
  use Phoenix.Component

  alias TodoWeb.LiveComponents.TaskCard

  import TodoWeb.CoreComponents

  attr :cards, :list, required: true

  def card_stack(assigns) do
    ~H"""
    <div class="bg-gray-500 p-4 flex flex-col gap-2">
      <.live_component :for={card <- @cards} module={TaskCard} id={card} />
      <.form for={@new_card_form}>
        <.input type="text" name="title" label="Title" field={@new_card_form[:title]} />
      </.form>
    </div>
    """
  end
end
