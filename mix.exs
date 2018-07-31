defmodule MyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_app,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {MyApp, []}
    ]
  end

   # Run "mix help deps" to learn about dependencies.
   defp deps do
    [{:cowboy, "~> 2.3"},
    {:plug, "~> 1.5"},
    {:httpoison, "~> 1.1"},
    {:poison, "~> 3.1"},
    {:earmark, "~> 1.2", only: :dev},
    {:ex_doc, "~> 0.18.3", only: :dev}
    ]
  end
end
