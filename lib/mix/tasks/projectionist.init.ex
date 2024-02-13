defmodule Mix.Tasks.Projectionist.Init do
  @moduledoc """
  Creates .projections.json file in the root directory of your project.

  When this task is executed in the root directory of an umbrella project,
  it creates .projections.json files recursively for each app in the project. 
  """

  @shortdoc "Creates .projections.json file for your project"

  @recursive true

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    if File.exists?("mix.exs") do
      projectionist_init(args)
    else
      Mix.shell().error("There is no mix.exs here, aborting.")
    end
  end

  defp projectionist_init(args) do
    if writable?(".projections.json", args) do
      write_file(".projections.json", process_template())
    end
  end

  defp writable?(file, args) do
    !File.exists?(file) ||
      "--force" in args ||
      Mix.shell().yes?("Overwrite existing #{file}?")
  end

  defp write_file(file, data) do
    Mix.shell().info([:green, "* creating ", :reset, file])
    File.write!(file, data)
  end

  defp process_template() do
    app = app_name()

    EEx.eval_file(template_file(),
      app_underscored: Macro.underscore(app),
      app_camelized: Macro.camelize(app),
      glob_modulized: "{camelcase|capitalize|dot}"
    )
  end

  defp app_name() do
    to_string(Mix.Project.config()[:app])
  end

  defp template_file() do
    dir = :code.priv_dir(:projectionist_init)
    Path.join(dir, "projections.eex.json")
  end
end
