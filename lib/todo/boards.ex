defmodule Todo.Boards do
  alias Todo.Boards.{Board, Section, Card, Step}
  alias Todo.Repo
  import Ecto.Query

  def get_sections_from_board(board_id) do
    from(s in Section, where: s.board_id == ^board_id)
    |> Repo.all()
  end

  def get_cards_from_section(section_id) do
    from(c in Card, where: c.section_id == ^section_id)
    |> Repo.all()
  end

  def get_steps_from_card(card_id) do
    from(s in Step, where: s.card_id == ^card_id)
    |> Repo.all()
  end

  def get_boards() do
    Repo.all(
      from b in Board,
        left_join: s in assoc(b, :sections),
        left_join: c in assoc(s, :cards),
        select: {b, count(c.id, :distinct)},
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

  def create_section(board_id, attrs) do
    Repo.get_by!(Board, id: board_id)
    |> Ecto.build_assoc(:sections)
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  def create_card(section_id, attrs) do
    Repo.get_by!(Section, id: section_id)
    |> Ecto.build_assoc(:cards)
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  def delete_section(section_id) do
    from(s in Section, where: s.id == ^section_id) |> Repo.delete_all()
  end
end
