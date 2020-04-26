defmodule PhoenixElixirDokku.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_elixir_dokku,
      version: "0.1.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixElixirDokku.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.10"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      #{:ecto_sql, "~> 3.1"},
      #{:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.1", override: true},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  def changelog() do
    if File.exists?("CHANGELOG.md") do
      File.read!("CHANGELOG.md")
    else
      {:ok, cwd} = File.cwd()
      "File 'CHANGELOG.md' does not exists in cwd: #{cwd}"
    end
  end

  def deps_lock() do
    if File.exists?("mix.lock") do
      {:ok, lockfile} = File.read("./mix.lock")
      re = ~r/"([^"]+)"[^"]+"([^"]+)"/

      lock_deps =
        lockfile
        |> String.split("\n")
        |> Enum.map(fn line ->
          case Regex.run(re, line) do
            [_, name, version] -> {name, version}
            _ -> nil
          end
        end)

      # to avoid the warnings in every key ("bamboo": {...} => should be bamboo: without quotes)
      # {lock_deps, _} = lockfile |> Code.eval_string()
      # lock_deps = lock_deps |> Map.to_list()

      lock_deps
      |> Enum.reduce([], fn el, acc ->
        case el do
          # my new version
          {name, version} -> [{name, version} | acc]
          # original version with Code.eval_string():
          {name, {_, _, version, _hash, _, _child_deps, _, _}} -> [{name, version} | acc]
          # {name, {_, _, version, _hash, _, _child_deps}} -> [%{name => %{lock_version: version, latest_version: nil, upgrade_available: false}} | acc ]
          # {name, {:git, _path, _hash, []}} -> [%{name => %{lock_version: :latest, latest_version: nil, upgrade_available: false}} | acc ]
          _ -> acc
        end
      end)
      |> Enum.map_join("\n", fn {name, version} -> "#{name}: #{version}" end)
    else
      {:ok, cwd} = File.cwd()
      "File 'mix.lock' does not exists in cwd: #{cwd}"
    end
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      # "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      # "ecto.reset": ["ecto.drop", "ecto.setup"],
      # "ecto.seeds": ["run priv/repo/seeds.exs"],
      # test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
