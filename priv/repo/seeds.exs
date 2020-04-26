# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixElixirDokku.Repo.insert!(%PhoenixElixirDokku.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhoenixElixirDokku.Accounts

IO.inspect(Accounts.list_users(), label: "Accounts.list_users")

users = [
  %{"name" => "A", "age" => 18}
]

users
|> Enum.each(fn u -> Accounts.create_user(u) end)

IO.inspect(Accounts.list_users(), label: "Accounts.list_users")
