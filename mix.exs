defmodule Telnyx.MixProject do
  use Mix.Project

  def project do
    [
      app: :telnyx,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:mojito, "~> 0.4.0"},
      {:jason, "~> 1.1"}
    ]
  end
end
