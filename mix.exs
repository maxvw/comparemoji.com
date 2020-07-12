defmodule Comparemoji.MixProject do
  use Mix.Project

  def project do
    [
      app: :comparemoji,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Comparemoji.Application, []}
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.2"},
      {:phoenix, "~> 1.5"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_view, "~> 0.14.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:html_sanitize_ex, "~> 1.3.0-rc3"},
      {:plug_cowboy, "~> 2.3"},
      {:floki, ">= 0.0.0", only: :test},
      {:credo, "~> 1.4.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
