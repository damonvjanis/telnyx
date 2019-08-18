defmodule Telnyx.MixProject do
  use Mix.Project

  def project do
    [
      app: :telnyx,
      version: "0.1.0",
      elixir: "~> 1.6",
      description: "Telnyx API Elixir Client",
      source_url: "https://github.com/damonvjanis/telnyx",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
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
      {:mojito, "~> 0.4.0"},
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    ]
  end
end
