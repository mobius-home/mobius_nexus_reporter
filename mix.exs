defmodule MobiusNexusReporter.MixProject do
  use Mix.Project

  @version "1.2.0"

  def project do
    [
      app: :mobius_nexus_reporter,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      dialyzer: dialyzer(),
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      preferred_cli_env: [docs: :docs, "hex.publish": :docs]
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
      {:mobius, "~> 0.5.1"},
      {:req, "~> 0.2.2"},
      {:ex_doc, "~> 0.27", only: :docs, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs() do
    [
      extras: ["README.md", "CHANGELOG.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/mobius-home/mobius_nexus_reporter",
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp description do
    "Nexus remote reporter for Mobius"
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/mobius-home/mobius_nexus_reporter"}
    ]
  end

  defp dialyzer() do
    [
      flags: [:missing_return, :extra_return, :unmatched_returns, :error_handling, :underspecs]
    ]
  end
end
