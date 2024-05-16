defmodule TodoWeb.ListComponent do
  alias TodoWeb.TaskComponent
  alias Todo.Tasks
  use TodoWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="h-full overflow-hidden">
      <div class="w-60 max-h-full flex flex-col card p-2">
        <%!-- Header --%>
        <div class="flex justify-between mb-1">
          <h3><%= @list.title %></h3>
          <button class="hover:bg-red-800 hover:text-white rounded px-1">
            <.icon name="hero-x-mark" />
          </button>
        </div>

        <%!-- List data --%>
        <ul class="flex flex-col gap-2 overflow-y-auto h-full fancy-scrollbar pr-2">
          <.live_component :for={task <- @tasks} module={TaskComponent} id={task.id} task={task} />
        </ul>

        <%!-- New task --%>
        <div
          class={[
            "self-center p-1 rounded-full",
            "flex flex-col items-center",
            "bg-neutral-300 hover:bg-neutral-200",
            "border border-slate-600",
            "transition-all cursor-pointer"
          ]}
          phx-click="toggle_new_task"
          phx-target={@myself}
        >
          <%= if @is_new_task_open do %>
            <.icon class="text-slate-600" name="hero-x-mark" />
          <% else %>
            <.icon class="text-slate-600" name="hero-plus" />
          <% end %>
        </div>

        <.form
          :if={@is_new_task_open}
          class={[
            "flex flex-col gap-2",
            "p-2 rounded",
            "bg-neutral-300",
            "border border-slate-600"
          ]}
          phx-submit="create_task"
          phx-target={@myself}
          for={@new_task_form}
        >
          <.input type="text" name="title" label="Task Title" field={@new_task_form[:title]} />
          <.button>Create</.button>
        </.form>
      </div>
    </div>
    """
  end

  def mount(socket) do
    new_socket =
      socket
      |> assign(new_task_form: to_form(%{}))
      |> assign(is_new_task_open: false)

    {:ok, new_socket}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, tasks: Tasks.get_tasks_from_list(assigns.list.id), list: assigns.list)}
  end

  def handle_event("toggle_new_task", _unsigned_params, socket) do
    {:noreply, assign(socket, is_new_task_open: !socket.assigns.is_new_task_open)}
  end

  def handle_event("create_task", unsigned_params, socket) do
    Tasks.create_task(socket.assigns.list.id, unsigned_params)

    {:noreply, socket}
  end
end
