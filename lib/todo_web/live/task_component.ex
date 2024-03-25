defmodule TodoWeb.TaskComponent do
  alias Todo.Tasks
  use TodoWeb, :live_component

  def render(%{steps: steps} = assigns) do
    done_steps_length = steps |> Enum.filter(& &1["done"]) |> length
    steps_length = steps |> length

    percentage =
      if steps_length == 0 do
        0
      else
        done_steps_length / steps_length * 100
      end

    assigns = assign(assigns, percentage: percentage)

    ~H"""
    <div class={[
      "p-2 flex flex-col border border-slate-600",
      "items-stretch rounded bg-neutral-300",
      "shadow-md cursor-pointer hover:bg-neutral-200"
    ]}>
      <h3 class="px-0.5"><%= @task.title %></h3>

      <%!-- <.modal id="aaa">
        <ul class={["flex flex-col gap-2"]}>
          <li :for={step <- @steps} class="flex items-center justify-between px-1">
            <div
              phx-click="toggle_done"
              phx-value-id={step["id"]}
              phx-target={@myself}
              class="flex items-center gap-2 cursor-pointer "
            >
              <div class={[
                "h-4 w-4 bg-white flex",
                "border-2 border-gray-400",
                "rounded",
                if(step["done"], do: "border-green-500")
              ]}>
                <.icon
                  name="hero-check"
                  class={if(step["done"], do: "text-green-500", else: "hidden")}
                />
              </div>

              <span class={if(step["done"], do: "line-through text-gray-500")}>
                <%= step["name"] %>
              </span>
            </div>

            <button
              class="rounded-full flex h-5 w-5 text-center cursor-pointer hover:bg-purple-600 hover:text-white"
              phx-click="remove_step"
              phx-value-id={step["id"]}
              phx-target={@myself}
            >
              <.icon name="hero-x-mark" />
            </button>
          </li>
        </ul>
      </.modal> --%>

      <.task_progress percentage={@percentage} />
      <%!-- </div> --%>

      <%!-- <.form for={@new_step_form} phx-target={@myself} phx-submit="add_step">
        <.input type="text" field={@new_step_form["step_name"]} />
      </.form> --%>
    </div>
    """
  end

  def mount(socket) do
    # new_step_form = to_form(%{"step_name" => ""})

    new_socket =
      socket
      # |> assign(new_step_form: new_step_form)
      # |> assign(steps: Tasks.get_steps_from_task(socket.assigns.task.id))
      |> assign(modal_show: false)

    {:ok, new_socket}
  end

  def update(assigns, socket) do
    new_socket =
      socket
      |> assign(steps: Tasks.get_steps_from_task(assigns.task.id))
      |> assign(assigns)

    {:ok, new_socket}
  end

  # def handle_event("toggle_done", %{"id" => step_id}, socket) do
  #   old_steps = socket.assigns.steps
  #   new_steps = Tasks.toggle_done(old_steps, String.to_integer(step_id))

  #   {:noreply, assign(socket, steps: new_steps)}
  # end

  # def handle_event("add_step", %{"step_name" => step_name}, socket) do
  #   old_steps = socket.assigns.steps
  #   new_steps = Tasks.add_step(old_steps, step_name)

  #   {:noreply, assign(socket, steps: new_steps)}
  # end

  # def handle_event("remove_step", %{"id" => step_id}, socket) do
  #   old_steps = socket.assigns.steps
  #   new_steps = Tasks.remove_step(old_steps, String.to_integer(step_id))

  #   {:noreply, assign(socket, steps: new_steps)}
  # end

  # def handle_event("toggle_hidden", _unsigned_params, socket) do
  #   {:noreply, assign(socket, hidden: !socket.assigns.hidden)}
  # end
end
