defmodule NinetyNineProblems.MixProject do
  use Mix.Project

  def project do
    [
      app: :ninety_nine_problems,
      version: "0.1.0",
      elixir: "~> 1.7",
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
      {:random, ">= 0.2.4"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},
      {:excheck, "~> 0.6", only: :test},
      {:triq, "~> 1.2", only: [:dev, :test]},
    ]
  end
end
