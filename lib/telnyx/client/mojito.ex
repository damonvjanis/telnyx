defmodule Telnyx.Client.Mojito do
  @behaviour Telnyx.Client

  require Logger

  @impl true
  def init do
    unless Code.ensure_loaded?(Mojito) do
      Logger.error """
      Could not find http client dependency.

      Please add Mojito to your dependencies:

          {:mojito, "~> 0.7"}

      Or set your own client:

          config :telnyx, :client, MyApp.CustomClient

      See Telnyx.Client docs for more info: https://hexdocs.pm/telnyx/Telnyx.Client.html
      """

      raise "missing mojito dependency"
    end

    {:ok, _} = Application.ensure_all_started(:mojito)
    :ok
  end

  @impl true
  def post(url, headers, data) do
    Mojito.post(url, headers, data, opts())
  end

  @impl true
  def patch(url, headers, data) do
    Mojito.patch(url, headers, data, opts())
  end

  @impl true
  def get(url, headers) do
    Mojito.get(url, headers, opts())
  end

  @impl true
  def delete(url, headers) do
    Mojito.delete(url, headers, opts())
  end

  defp opts() do
    case Mix.env() do
      :test -> [transport_opts: [verify: :verify_none]]
      _ -> []
    end
  end
end
