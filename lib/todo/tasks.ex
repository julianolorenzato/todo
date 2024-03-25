defmodule Todo.Tasks do
  alias Todo.Tasks.{Board, List, Task, Step}
  alias Todo.Repo
  import Ecto.Query

  def get_lists_from_board(board_id) do
    from(l in List, where: l.board_id == ^board_id)
    |> Repo.all()
  end

  def get_tasks_from_list(list_id) do
    from(t in Task, where: t.list_id == ^list_id)
    |> Repo.all()
  end

  def get_steps_from_task(task_id) do
    from(s in Step, where: s.task_id == ^task_id)
    |> Repo.all()
  end

  def get_boards() do
    Repo.all(
      from b in Board,
        left_join: l in assoc(b, :lists),
        left_join: t in assoc(l, :tasks),
        select: {b, count(t.id, :distinct)},
        # select: map(b, [:title, tasks_count: count(t.id)]),
        group_by: b.id
      # where: b.id == ^board_id
    )
  end

  def change_board(%Board{} = board, attrs \\ %{}) do
    Board.changeset(board, attrs)
  end

  def create_board(attrs) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert!()
  end

  def create_list(board_id, attrs) do
    Repo.get_by!(Board, id: board_id)
    |> Ecto.build_assoc(:lists)
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  def create_task(list_id, attrs) do
    Repo.get_by!(List, id: list_id)
    |> Ecto.build_assoc(:tasks)
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def delete_list(list_id) do
    from(l in List, where: l.id == ^list_id) |> Repo.delete_all()
  end
end
