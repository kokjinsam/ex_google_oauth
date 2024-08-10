# GoogleOAuth

A simple Google OAuth 2.0 client.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `google_oauth` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:google_oauth, "~> 1.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/google_oauth>.

## Usage

1. Load Google OAuth public key cert cache.

```elixir
  defmodule YourApplication do
    def start(_type, _args) do
      children = [
        GoogleOAuth.Certs
      ]

      opts = [strategy: :one_for_one, name: YourApplication.Supervisor]
      Supervisor.start_link(children, opts)
    end
  end
```

2. Configure your Google OAuth.
3. Start using. Thank you.
