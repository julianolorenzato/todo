defmodule TodoWeb.DumbLive do
  alias Todo.Boards
  use TodoWeb, :live_view

  def mount(params, session, socket) do
    socket = assign(socket, form: to_form(%{}))

    {:ok, socket}
  end

  def render(assigns) do
    # IO.inspect(assigns, label: "DOLE")

    ~H"""
    <.form id="form" phx-submit="create_section" for={@form}>
      <.input type="text" label="title" field={@form[:title]} />
      <.button>Opa</.button>
    </.form>
    """
  end

  def handle_event("create_section", %{"title" => _} = params, socket) do
    case Boards.create_section(3, params) do
      {:ok, created_section} ->
        {:noreply, assign(socket, form: to_form(%{"title" => ""}))}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(%{}, errors: changeset.errors))}
    end
  end

  # def handle_event("form_change", unsigned_params, socket) do
  #   {:noreply, assign(socket, form: to_form(unsigned_params))}
  # end
end
