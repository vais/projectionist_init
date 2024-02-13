# mix projectionist.init

projectionist.init is a mix task to create `.projections.json` file for your Elixir project.

## Installation

To install directly from github:

    $ mix archive.install github vais/projectionist_init

Or, to build and install locally, clone this repo, then run:

    $ mix do archive.build, archive.install

## Usage

In your project directory, run:

    $ mix projectionist.init

This will create a `.projections.json` file at the root of your project.

When this task is executed in the root directory of an *umbrella* project,
it creates `.projections.json` files recursively _for each app_ in the project. 

If a `.projections.json` file already exists, you will be prompted to overwrite it.
You can pass `--force` flag if you prefer not to be prompted.

## Customization

The most obvious way to customize projections is by editing the `.projections.json`
file directly after it's been generated.

That works, but who wants to do that for every new project?
So the next option is to clone this repo to your computer,
edit `priv/projections.eex.json` file, then `mix do archive.build, archive.install`

Now every time you run `mix projections.init`, it will create `.projections.json`
file with your custom projections.

That works, but what if you want to share your projections with a team, or across
multiple machines?
Fork this repo, customize, then `mix archive.install` from your own fork.

This is the reason projectionist.init is not on hex.pm - *it is meant to be forked*.

## Examples

Let's create a new LiveView for our hypothetical application named `ranger` that
lives in a directory called `testing-liveview` (we're making application name and
directory name different on purpose, to make it clear that our skeleton generators
will use application name for the generated code, and ignore the directory name)

```
:Elive example_live
```

This will generate the following skeleton for us at `lib/ranger_web/live/example_live.ex`:
```elixir
defmodule RangerWeb.ExampleLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    """
  end
end
```

Let's start writing a test for it:
```
:Etest (or simply :A)
```

This will generate the following skeleton for us at `test/ranger_web/live/example_live_test.ex`:
```elixir
defmodule RangerWeb.ExampleLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"")
  end
end
```

What if we want our LiveView to be nested under a shared parent directory?
```
:Elive something_live/edit
```

This will generate the following skeleton for us at `lib/ranger_web/live/something_live/edit.ex`:
```elixir
defmodule RangerWeb.SomethingLive.Edit do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    """
  end
end
```

Note that both the file path and the module path reflect the desired nested structure.
I.e. with this approach, we can accommodate any directory/module organization to suit the needs of the project.
