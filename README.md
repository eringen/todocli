# Todo

A simple CLI todo list manager written in Elixir. Tasks are stored as Markdown checkboxes in `~/.todo.md`.

## Usage

```
todo                  # list tasks
todo add "buy milk"   # add a task
todo done 1           # mark task 1 as done
todo remove 1         # remove task 1
```

## Build

Requires Elixir ~> 1.11.

```
mix escript.build
```

This produces a `todo` binary you can place on your `PATH`.

