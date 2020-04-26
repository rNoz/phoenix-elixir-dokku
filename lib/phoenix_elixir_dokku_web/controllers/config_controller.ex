defmodule PhoenixElixirDokkuWeb.ConfigController do
  use PhoenixElixirDokkuWeb, :controller

  require Logger

  defimpl Jason.Encoder, for: [Tuple] do
    def encode(struct, opts) do
      Jason.Encode.list(Tuple.to_list(struct), opts)
    end
  end

  def index(conn, params) do
    data_form = %{}

    data_assign = [
      {:truncate, 8192},
      {:level, "info"},
      {:sync_threshold, 20},
      {:discard_threshold, 500},
      {:handle_otp_reports, true},
      {:handle_sasl_reports, false},
      {:discard_threshold_periodic_check, 30_000}
    ]

    data_form =
      data_assign
      |> Enum.reduce(
        data_form,
        fn {k, defv}, data_form ->
          kstr = Atom.to_string(k)
          defvstr = "#{defv}"
          cfg = Application.get_env(:logger, k, defvstr)
          defvstr = "#{cfg}"
          param = Map.get(params, kstr, defvstr)

          v =
            cond do
              is_number(defv) ->
                case Integer.parse(param) do
                  {v, _} -> v
                  _ -> defv
                end

              k == :level ->
                case param do
                  "debug" -> :debug
                  "info" -> :info
                  "warn" -> :warn
                  "error" -> :error
                  _ -> Application.get_env(:logger, :level, :info)
                end

              true ->
                case param do
                  "true" -> true
                  "false" -> false
                end
            end

          Application.put_env(:logger, k, v)
          Map.put(data_form, k, v)
        end
      )

    console_backend = Application.get_env(:logger, :console)

    console_backend_assign = [
      {:max_buffer, 32},
      {:handle_otp_reports, true},
      {:handle_sasl_reports, false},
      {:device, :user}
    ]

    {console_backend, data_form_all} =
      console_backend_assign
      |> Enum.reduce(
        {console_backend, data_form},
        fn {k, defv}, {console_backend, data_form} ->
          kstr = "console_#{Atom.to_string(k)}"
          defvstr = "#{defv}"
          cfg = Keyword.get(console_backend, k, defvstr)
          defvstr = "#{cfg}"
          param = Map.get(params, kstr, defvstr)

          v =
            cond do
              is_number(defv) ->
                case Integer.parse(param) do
                  {v, _} -> v
                  _ -> defv
                end

              k == :device ->

                case param do
                  "user" -> :user
                  "standard_error" -> :standard_error
                end

              true ->
                case param do
                  "true" -> true
                  "false" -> false
                end
            end

          {
            Keyword.put(console_backend, k, v),
            Map.put(data_form, String.to_atom(kstr), v)
          }
        end
      )

    Application.put_env(:logger, :console, console_backend)
    Logger.configure_backend(:console, console_backend)

    keys = [:console, :backends, :compile_time_application, :compile_time_purge_matching]

    inspection =
      keys
      |> Enum.map(fn k -> {k, Application.get_env(:logger, k)} end)
      |> Enum.into(%{})

    Logger.configure(
      data_form
      |> Map.to_list()
    )

    inspection = Map.put(inspection, :logger, data_form)

    data_form_all = Map.put(data_form_all, :inspection, Jason.encode!(inspection, pretty: true))

    Logger.debug("debug message")
    Logger.info("info message")
    Logger.warn("warn message")
    Logger.error("error message")

    render(conn, "index.html", data_form_all)
  end
end
