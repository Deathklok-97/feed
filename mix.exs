defmodule Algolia.MixProject do
  use Mix.Project

  def project do
    [
      app: :algolia,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:remix, "~> 0.0.2", only: :dev},
      {:ex_doc, "~> 0.28.2", only: :dev, runtime: false},
      {:proper, "~> 1.4", only: :test},
      {:poolboy, "~> 1.5"},
      {:blocking_queue, "~> 1.3"}
    ]
  end
end
