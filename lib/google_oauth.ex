defmodule GoogleOAuth do
  @moduledoc """
  Documentation for `GoogleOAuth`.
  """

  alias GoogleOAuth.Config

  @callback authorization_url(Keyword.t()) :: binary()

  @callback token(binary(), Keyword.t()) :: {:ok, map()} | {:error, :invalid_authorization_code}

  @callback userinfo(map()) :: {:ok, Joken.claims()} | {:error, Joken.error_reason()}

  def authorization_url(opts) do
    Config.adapter().authorization_url(opts)
  end

  def token(authorization_code, opts) do
    Config.adapter().token(authorization_code, opts)
  end

  def userinfo(token) do
    Config.adapter().userinfo(token)
  end
end
