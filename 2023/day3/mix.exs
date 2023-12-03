defmodule Day3.MixProject do
  use Mix.Project

  def project do
    [
      app: :day3,
      version: "0.1.0",
      elixir: "~> 1.17-dev",
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
      {:credo, "~>1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mock, "~> 0.3.0", only: :test},
      {:tapex, "~> 0.1.0", only: :test},
    ]
  end
end
