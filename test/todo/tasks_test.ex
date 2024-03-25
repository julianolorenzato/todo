defmodule Test.Todo.TasksTest do
  alias Todo.Tasks
  use ExUnit.Case
  doctest Tasks

  describe "get_all_steps/0" do
    test "should return all steps" do
      expected = [
        %{"name" => "the last", "done" => false},
        %{"name" => "do another thing", "done" => false},
        %{"name" => "do this", "done" => false}
      ]

      got = Tasks.get_all_steps() |> Enum.map(&Map.delete(&1, "id"))

      assert expected == got
    end
  end

  describe "toggle_done/1" do
    test "should toggle 'do this' step" do
      expected = [
        %{"name" => "the last", "done" => false},
        %{"name" => "do another thing", "done" => false},
        %{"name" => "do this", "done" => true}
      ]

      all = Tasks.get_all_steps()
      target_id = Enum.at(all, 2)["id"]

      got = all |> Tasks.toggle_done(target_id) |> Enum.map(&Map.delete(&1, "id"))

      assert expected == got
    end
  end
end
