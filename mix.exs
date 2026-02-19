defmodule Todo.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo,
      version: "0.1.0",
      elixir: "~> 1.11",
      escript: escript_config()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript_config do
    [
      main_module: Todo.CLI
    ]
  end
end
