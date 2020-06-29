defmodule Telnyx.MixProject do
  use Mix.Project

  def project do
    [
      app: :telnyx,
      version: "0.2.1",
      elixir: "~> 1.7",
      description: "Telnyx API Elixir Client",
      source_url: "https://github.com/damonvjanis/telnyx",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Suppress warnings
      xref: [
        exclude: [
          Mojito
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Telnyx.Application, []},
      env: [client: Telnyx.Client.Mojito, base_url: "https://api.telnyx.com/v2"]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["damon janis <damonvjanis@gmail.com>"],
      links: %{github: "https://github.com/damonvjanis/telnyx"}
    ]
  end

  defp deps do
    [
      {:mojito, "~> 0.7.0", optional: true},
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
