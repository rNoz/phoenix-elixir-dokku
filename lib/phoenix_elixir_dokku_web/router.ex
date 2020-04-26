defmodule PhoenixElixirDokkuWeb.Router do
  use PhoenixElixirDokkuWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixElixirDokkuWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/runtime-error-conn", PageController, :runtime_error_conn
    get "/runtime-error-match", PageController, :runtime_error_match
    get "/config", ConfigController, :index
  end

end
