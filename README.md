# PhoenixElixirDokku

## Production

```
PORT=4000 SECRET_KEY_BASE=$(mix phx.gen.secret) HOST=localhost MIX_ENV=prod mix phx.digest

SCHEME=http PORT=4000 SECRET_KEY_BASE=$(mix phx.gen.secret) HOST=localhost MIX_ENV=prod mix phx.server
```

## Install

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

