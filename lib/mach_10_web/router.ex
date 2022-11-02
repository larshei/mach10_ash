defmodule Mach10Web.Router do
  use Mach10Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Mach10Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mach10Web do
    pipe_through :browser

    get "/", PageController, :index
    live "/live", PageLive, :index
    live "/live/modal/:size", PageLive, :modal
    live "/live/slide_over/:origin", PageLive, :slide_over
    live "/live/pagination/:page", PageLive, :pagination
  end

  scope "/api" do
    pipe_through :api

    forward "/v1", Mach10Web.Records.Router
  end

  scope "/json_api" do
    pipe_through :api
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Mach10Web.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
