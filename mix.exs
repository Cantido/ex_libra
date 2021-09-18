# SPDX-FileCopyrightText: 2021 Rosa Richter
#
# SPDX-License-Identifier: MIT

defmodule ExLibra.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_libra,
      description: "A Libravatar client",
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://git.sr.ht/~cosmicrose/ex_libra",
      homepage_url: "https://git.sr.ht/~cosmicrose/ex_libra"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Rosa Richter"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/Cantido/ex_libra",
        "sourcehut" => "https://git.sr.ht/~cosmicrose/ex_libra",
        "Sponsor" => "https://liberapay.com/rosa"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:dns, "~> 2.3"},
      {:ex_doc, "~> 0.25", only: :dev, runtime: false}
    ]
  end
end
