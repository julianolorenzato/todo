defmodule TodoWeb.Router do
  use TodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TodoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoWeb do
    pipe_through :browser

    get "/", BoardController, :to_index
    # get "/boards", BoardController, :index
    get "/boards/new", BoardController, :new
    # post "/boards", BoardController, :create
    live "/boards", BoardsLive

    live_session :kanban, on_mount: TodoWeb.Kanban, layout: {TodoWeb.Layouts, :kanban} do
      live "/boards/:id", BoardLive
    end

    live_session :task, layout: {TodoWeb.Layouts, :tasks_manager} do
      live "/task", TaskLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:todo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TodoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
