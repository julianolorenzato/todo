defmodule TodoWeb.TaskLive do
  alias Todo.Tasks.Task
  use TodoWeb, :live_view

  alias TodoWeb.LiveComponents.TaskCard

  def render(assigns) do
    ~H"""
    <div>
      <.modal show={@new_task_modal} id="some">
        <.form for={@new_task_form}>
          <.input type="text" name="title" label="Title" field={@new_task_form[:title]} />
          <.input
            type="text"
            name="description"
            label="Description"
            field={@new_task_form[:description]}
          />
          <button>Submit</button>
        </.form>
      </.modal>

      <div class="flex gap-2">
        <.task_stack new_task_form={@new_task_form} tasks={[1, 2, 3, 4, 5]} />
        <.task_stack new_task_form={@new_task_form} tasks={[6, 7, 8, 9, 10]} />
        <.task_stack new_task_form={@new_task_form} tasks={[11, 22, 33, 44, 55]} />
        <.task_stack new_task_form={@new_task_form} tasks={[12, 23, 34, 45, 56]} />
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-3 lg:grid-cols-4 justify-items-center gap-4">
        <%!-- <.live_component module={TaskCard} id="1" />
        <.live_component module={TaskCard} id="2" />
        <.live_component module={TaskCard} id="3" />
        <.live_component module={TaskCard} id="4" />
        <.live_component module={TaskCard} id="5" />
        <.live_component module={TaskCard} id="6" /> --%>
        <div class="h-80 w-60 bg-slate-400 rounded flex items-center justify-center">
          <div
            phx-click={show_modal("some")}
            class="cursor-pointer text-7xl h-20 w-20 text-center align-middle text-white border-4 border-white rounded-full"
          >
            +
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    new_task_form = Task.changeset(%Task{}, %{}) |> to_form()

    {:ok, assign(socket, new_task_modal: false, new_task_form: new_task_form)}
  end

  def handle_event("open_new_task_modal", _unsigned_params, socket) do
    {:noreply, assign(socket, new_task_modal: true)}
  end
end
