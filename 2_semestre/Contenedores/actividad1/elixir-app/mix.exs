defmodule HelloWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_web,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {HelloWeb, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:plug, "~> 1.14"}
    ]
  end
end
