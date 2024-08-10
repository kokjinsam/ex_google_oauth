defmodule GoogleOAuth.Certs do
  @moduledoc false

  use JokenJwks.DefaultStrategyTemplate

  alias GoogleOAuth.Config

  def init_opts(opts) do
    Keyword.merge(opts,
      should_start: Config.fetch_certs?(),
      jwks_url: Config.cert_url()
    )
  end
end
