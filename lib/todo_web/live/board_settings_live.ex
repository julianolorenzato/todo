defmodule TodoWeb.BoardSettingsLive do
  use TodoWeb, :live_view

  # def mount(_params, _session, socket) do
  #   {:ok, socket}
  # end

  def settings_view(%{live_action: :info} = assigns) do
    ~H"""
    <h1>Settings</h1>
    """
  end

  def settings_view(%{live_action: :members} = assigns) do
    ~H"""
    AAA
    """
  end

  def handle_params(unsigned_params, uri, socket) do
    {:noreply, socket}
  end
end
