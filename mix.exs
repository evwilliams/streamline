defmodule Streamline.MixProject do
  use Mix.Project

  def project do
    [
      app: :streamline,
      version: "0.1.0",
      elixir: "~> 1.17",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: [],
      package: package(),
      name: "Streamline",
      description: "A collection of pipe-related macros."
    ]
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "streamline",
      licenses: ["Apache-2.0"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end
end
