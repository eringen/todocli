defmodule Todo.CLI do
  def main(args) do
    case args do
      [] ->
        Todo.show()

      ["add" | rest] ->
        Todo.add(Enum.join(rest, " "))

      ["done", index] ->
        Todo.done(String.to_integer(index))

      ["remove", index] ->
        Todo.remove(String.to_integer(index))

      _ ->
        IO.puts("""
        Usage:
          todo
          todo add "task"
          todo done <index>
          todo remove <index>
        """)
    end
  end
end
