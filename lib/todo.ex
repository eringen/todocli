defmodule Todo do
  @todo_file Path.join(System.user_home!(), ".todo.md")

  def show do
    todos()
    |> Enum.with_index(1)
    |> Enum.each(fn {task, i} ->
      IO.puts("#{i}. #{task}")
    end)
  end

  def add(task) when task != "" do
    File.write!(@todo_file, "- [ ] #{task}\n", [:append])
    IO.puts("Added: #{task}")
  end

  def done(index) do
    update(index, fn task ->
      String.replace(task, "[ ]", "[x]")
    end)
  end

  def remove(index) do
    lines =
      todos()
      |> List.delete_at(index - 1)

    File.write!(@todo_file, Enum.join(lines, "\n") <> "\n")
    IO.puts("Removed item #{index}")
  end

  defp update(index, fun) do
    lines = todos()

    updated =
      lines
      |> Enum.with_index()
      |> Enum.map(fn
        {task, i} when i == index - 1 -> fun.(task)
        {task, _} -> task
      end)

    File.write!(@todo_file, Enum.join(updated, "\n") <> "\n")
  end

  defp todos do
    case File.read(@todo_file) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.map(&String.trim/1)

      _ ->
        []
    end
  end
end
