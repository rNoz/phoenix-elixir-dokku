defmodule PhoenixElixirDokkuWeb.PageController do
  use PhoenixElixirDokkuWeb, :controller
  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def runtime_error_match(conn, params) do
    Logger.error("Custom error message before runtime_error params")
    IO.inspect(params, label: "runtime_error params")
    1 = params
  end

  def runtime_error_conn(conn, _params) do
    Logger.error("Custom error message before runtime_error conn")
    IO.puts("runtime_error conn")
    PhoenixElixirDokkuWeb.Router.Helpers.page_path()
    conn
  end
end
