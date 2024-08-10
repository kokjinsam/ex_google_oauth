defmodule GoogleOAuth.Config do
  @moduledoc false

  @default_adapter GoogleOAuth.HTTPClient
  @default_cert_url "https://www.googleapis.com/oauth2/v3/certs"
  @default_oauth_url "https://accounts.google.com/o/oauth2/v2/auth"
  @default_token_url "https://oauth2.googleapis.com/token"
  @default_token_iss ["https://accounts.google.com", "accounts.google.com"]

  def adapter do
    Application.get_env(:google_oauth, :adapter) ||
      @default_adapter
  end

  def fetch_certs? do
    case Application.get_env(:google_oauth, :fetch_certs?) do
      reply when is_boolean(reply) -> reply
      _other -> true
    end
  end

  def cert_url do
    Application.get_env(:google_oauth, :cert_url) ||
      @default_cert_url
  end

  def client_id(opts \\ []) do
    Keyword.get(opts, :client_id) ||
      Application.fetch_env!(:google_oauth, :client_id)
  end

  def client_secret(opts \\ []) do
    Keyword.get(opts, :client_secret) ||
      Application.fetch_env!(:google_oauth, :client_secret)
  end

  def redirect_uri(opts \\ []) do
    Keyword.get(opts, :redirect_uri) ||
      Application.fetch_env!(:google_oauth, :redirect_uri)
  end

  def scopes(opts \\ []) do
    Keyword.get(opts, :scopes) ||
      Application.get_env(:google_oauth, :scopes)
  end

  def state(opts \\ []) do
    Keyword.get(opts, :state) ||
      Application.get_env(:google_oauth, :state)
  end

  def oauth_url do
    Application.get_env(:google_oauth, :oauth_url) ||
      @default_oauth_url
  end

  def token_url do
    Application.get_env(:google_oauth, :token_url) ||
      @default_token_url
  end

  def id_token_iss do
    Application.get_env(:google_oauth, :id_token_iss) ||
      @default_token_iss
  end
end
