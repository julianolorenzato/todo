defmodule TodoWeb.HomeHTML do
  use TodoWeb, :html

  def index(assigns) do
    ~H"""
    <p class="text-white">THis is the HOME</p>
    """
  end
end
