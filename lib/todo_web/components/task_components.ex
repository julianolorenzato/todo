defmodule TodoWeb.TaskComponents do
  alias Todo.Tasks.Task
  alias TodoWeb.LiveComponents.TaskCard
  use Phoenix.Component

  import TodoWeb.CoreComponents

  attr :percentage, :integer, required: true

  def task_progress(assigns) do
    ~H"""
    <div class="relative h-2 w-full border border-purple-700 bg-white rounded-md overflow-hidden">
      <div
        style={"width: #{@percentage}%"}
        class="bg-purple-600 i-shadow h-full flex items-center transition-all"
      >
        <%!-- <%= @percentage %>% --%>
      </div>
    </div>
    """
  end

  attr :tasks, :list, required: true

  def task_stack(assigns) do
    ~H"""
    <div class="bg-gray-500 p-4 flex flex-col gap-2">
      <.live_component :for={task <- @tasks} module={TaskCard} id={task} />
      <.form for={@new_task_form}>
        <.input type="text" name="title" label="Title" field={@new_task_form[:title]} />
      </.form>
    </div>
    """
  end
end
