defmodule GoogleOAuth.IDToken do
  @moduledoc false

  use Joken.Config, default_signer: nil

  alias GoogleOAuth.Config

  add_hook(JokenJwks, strategy: GoogleOAuth.Certs)

  @impl Joken.Config
  def token_config do
    default_claims(skip: [:aud, :iss, :jti])
    |> add_claim("iss", nil, &(&1 in Config.id_token_iss()))
    |> add_claim("aud", nil, &(&1 == Config.client_id()))
    |> add_claim("sub", nil, &is_binary/1)
    |> add_claim("email", nil, &is_binary/1)
  end
end
