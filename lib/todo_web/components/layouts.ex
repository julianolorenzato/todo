defmodule TodoWeb.Layouts do
  use TodoWeb, :html

  alias Phoenix.LiveView.JS

  embed_templates "layouts/*"

  def toggle_kanban_sidebar() do
    %JS{}
    |> JS.toggle_class("w-10 w-60", to: "#kanban_sidebar")
    |> JS.toggle_class("hero-chevron-left hero-chevron-right", to: "#kanban_sidebar_toggle_icon")
    |> JS.toggle_class("hidden", to: "#kanban_sidebar_items")
  end

  # defp sidebar_item(assigns) do
  #   ~H"""
  #   <.link>
  #     <li href={@href} patch={@patch} navigate={@navigate}>
  #       <span></span>
  #     </li>
  #   </.link>
  #   """
  # end
end
