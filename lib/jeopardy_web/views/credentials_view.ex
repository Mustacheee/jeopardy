defmodule JeopardyWeb.CredentialView do
  use JeopardyWeb, :view
  alias JeopardyWeb.CredentialView

  def render("index.json", %{credentials: credentials}) do
    %{data: render_many(credentials, CredentialView, "credential.json")}
  end

  def render("show.json", %{credential: credential}) do
    %{data: render_one(credential, CredentialView, "credential.json")}
  end

  def render("credential.json", %{credential: credential}) do
    %{id: credential.id,
      email: credential.email}
  end
end
