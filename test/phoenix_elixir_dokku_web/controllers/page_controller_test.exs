defmodule PhoenixElixirDokkuWeb.PageControllerTest do
  use PhoenixElixirDokkuWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to PhoenixElixirDokku"
  end
end
