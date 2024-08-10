defmodule GoogleOAuth.HTTPClient do
  @moduledoc false

  @behaviour GoogleOAuth

  alias GoogleOAuth.Config
  alias GoogleOAuth.IDToken

  @doc """
  Creates the authorization request URL.

  See https://developers.google.com/identity/protocols/oauth2/web-server#creatingclient
  """
  @impl GoogleOAuth
  def authorization_url(opts) do
    params = [
      client_id: Config.client_id(opts),
      response_type: "code",
      redirect_uri: Config.redirect_uri(opts),
      state: Config.state(opts),
      scope:
        Config.scopes(opts)
        |> parse_scopes()
    ]

    query_params =
      Enum.reject(params, &is_nil(elem(&1, 1)))
      |> Enum.into(%{})
      |> URI.encode_query(:rfc3986)

    "#{Config.oauth_url()}?#{query_params}"
  end

  defp parse_scopes(scopes) do
    case scopes do
      scopes when is_list(scopes) -> Enum.join(scopes, " ")
      _other -> nil
    end
  end

  @doc """
  Retrieves Google OAuth token using authorization code.
  """
  @impl GoogleOAuth
  def token(authorization_code, opts) do
    params = [
      client_id: Config.client_id(opts),
      client_secret: Config.client_secret(opts),
      code: authorization_code,
      grant_type: "authorization_code",
      redirect_uri: Config.redirect_uri(opts)
    ]

    case Req.post!(Config.token_url(), form: params) do
      %Req.Response{status: 200} = res -> {:ok, res.body}
      _reply -> {:error, :invalid_authorization_code}
    end
  end

  @doc """
  Retrieves info from `id_token`.
  """
  @impl GoogleOAuth
  def userinfo(token) do
    IDToken.verify_and_validate(token["id_token"])
  end
end
